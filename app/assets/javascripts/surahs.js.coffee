#Transforme 1 en 001
convertSourate = (num) =>
  num = num.toString()
  if num .length == 1
    num = "00#{num}"
  else if num.length == 2
    num = "0#{num}"
  else
    num


#Transforme 1 en 01
convertFichier = (num) =>
  num = num.toString();
  if num.length == 1
    num = "0"+num
  num

#Converti un temps en milliseconde
convert_to_milliseconde = (time) =>
  tab                   = time.split(':')
  heures                 = parseFloat(tab[0]) * 3600000
  minutes         = parseFloat(tab[1]) * 60000
  secondes         = parseFloat(tab[2]) * 1000
  heures + minutes + secondes

#Charge un fichier Xml en ajax
loadXMLDOC = (xml_url) =>
  if window.XMLHttpRequest
    xmlhttp=new XMLHttpRequest();
  else
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  xmlhttp.open("GET",xml_url,false);
  xmlhttp.send();
  xmlDoc=xmlhttp.responseXML;



#Récupère le fichier xml global
get_ruku_detail =() =>
  url_detail  = 'https://s3.amazonaws.com/hafizbe/RukuDetail.xml'
  docXml = loadXMLDOC url_detail

#Récupère la vlist d'une sourate
get_vlist =  (docXml, num_sourate) =>
  doc = docXml.getElementsByTagName "marker"
  for i in [0...doc.length]
    if doc[i].getAttribute("name") == num_sourate
      vlist = doc[i].getAttribute("vlist")
      break;
  vlist.split ","

# Détermine dans quel fichier se trouve un verset
get_file_for_verset = (vlist, from_verset) =>
  i = 1
  from_verset = parseInt from_verset
  result = 1
  unless from_verset == 1
    for a in vlist
      a = parseInt a
      if from_verset == a
        result = i
        break
      else
        if from_verset < a
          result = i - 1
          break
        else
          if i == vlist.length
            result = i
            break
      i++
  result

#Récupère le marker associé au début du verset (Exemple : Le verset 24 correspond au marker 4 du fichier xml)
get_the_marker = (from_verset, file_of_verset, vlist) =>
  marker = 0
  unless parseInt(from_verset) == 1
    if file_of_verset == 1
      marker = from_verset
    else
      marker = from_verset - vlist[file_of_verset-1]
  marker


#Retourne dans un tableau tous les markers
get_time_ayah = (xml_url) =>
  tableau = []
  i = 0
  $.ajax
    type: "GET"
    url: xml_url
    dataType: "xml"
    success:  (xml) =>
      $(xml).find('markers').each ()->
        $(this).find('marker').each ()->
          tableau[i] = $(this).attr("time")
          i++
  return tableau

#Return url xml et mp3 pour une sourate, en foncttion du récitateur et du nombre de fichier (01, 02 etc..)
get_url_fichier = (numSourate, recitateur, numero_fichier) =>
  surah = new Array(2)

  $.ajax
    type: "GET"
    url: "/api/v1/get_url_amazon?recitator="+recitateur+"&surah="+numSourate+"&num_fichier="+numero_fichier
    dataType: "JSON"
    async: false
    success:  (data) =>
      surah[0] = data[0].scheme+"://"+data[0].host+data[0].path+"?"+data[0].query
      surah[1] = data[1].scheme+"://"+data[1].host+data[1].path+"?"+data[1].query
      return
    error: =>
      alert 'Error occured'

  return surah



play_recitation = (_id_surah, _recitator, _from_verset, _to_verset) =>
  # Get le fichier de référence détails
  ruku_detail = get_ruku_detail()

  #Récupération de la vlist pour la sourate
  vlist = get_vlist ruku_detail, _id_surah
  nb_fichier = vlist.length

  #Dans quel fichier se trouve le verset où on veut commencer la lecture ?
  file_of_verset = get_file_for_verset vlist, _from_verset
  console.log file_of_verset

  current_marker = get_the_marker _from_verset, file_of_verset, vlist

  url_fichier = get_url_fichier convertSourate(_id_surah) , _recitator, convertFichier file_of_verset

  fichier_xml = url_fichier[1]

  play_fichier url_fichier, file_of_verset, nb_fichier, _id_surah, _recitator, fichier_xml, current_marker


# Lit le fichier mp3 en s'aidant du fichier xml.



play_fichier = (_url_fichier, _fichier_temp, _nb_fichier, _num_sourate, _recitateur, _fichier_xml, _current_marker) =>
  console.log player
  player.next()
  fichier_mp3   = _url_fichier[0]
  fichier_xml   = _url_fichier[1]
  tab_duration = []
  i = 0
  $.ajax
    type: "GET"
    url: fichier_xml
    dataType: "xml"
    success:  (xml) =>
      $(xml).find('markers').each ()->
        $(this).find('marker').each ()->
          tab_duration[i] = $(this).attr("time")
          i++
      player.current_marker = _current_marker
      player.current_file_id = _fichier_temp

      console.log player

      if player.current_marker == 0
        player.state_auto_play = true
      else
        player.state_auto_play = false
      if son_exist player.current_file_id
        sound = get_sound_by_id id
        sound.setPosition(convert_to_milliseconde tab_duration[player.current_marker])
        console.log "Cela doit aller jusqua #{convert_to_milliseconde tab_duration[player.current_marker]}"
        sound.play()
      else
        soundManager.createSound({
          id: _fichier_temp
          url: fichier_mp3,
          stream: true
          autoLoad: true
          autoPlay: player.state_auto_play
          multiShotEvents: false
          multiShot: false
          onfinish : =>

            if (_fichier_temp + 1) <= _nb_fichier
              console.log "Terminé !"

              new_fichier_temp = _fichier_temp + 1
              url_fichier = get_url_fichier convertSourate(_num_sourate) , _recitateur, convertFichier (new_fichier_temp)
              fichier_xml   = url_fichier[1]
              play_fichier url_fichier ,_fichier_temp + 1, _nb_fichier, _num_sourate, _recitateur, fichier_xml, 0
              return
          whileplaying : =>
            console.log " Position => #{s.position} / #{convert_to_milliseconde(tab_duration[player.current_marker + 1])} "
            if s.position > convert_to_milliseconde(tab_duration[player.current_marker + 1])
             old_marker = parseInt(player.current_marker)
             player.current_marker++
             console.log "OLD MARKER => #{old_marker}"
             if (old_marker != 0 || _fichier_temp !=1) || _num_sourate == "1"
               console.log " JE passe au suivant ! "
               console.log player
               player.next()
            return
          onload : =>
            console.log "Le son est chargé ! Etat => #{s.playState}"
            if s.playState == 0
              s.play({
                position:  convert_to_milliseconde tab_duration[player.current_marker]
                multiShotEvents: true
                whileplaying : =>
                  current_position = parseInt(s.position)
                  millisecond_next_marker = parseInt(convert_to_milliseconde(tab_duration[parseInt(player.current_marker) + 1]))
                  console.log "#{current_position} / #{millisecond_next_marker}"
                  if current_position > millisecond_next_marker
                    old_marker = player.current_marker
                    player.current_marker++
                    if (old_marker != 0 || _fichier_temp !=1) || _num_sourate == "1"
                      console.log player
                      player.next()

                onfinish : =>
                  if (_fichier_temp + 1) <= _nb_fichier
                    console.log "Terminé !"
                    console.log "num sourate => #{convertSourate(_num_sourate)}"

                    new_fichier_temp = _fichier_temp + 1
                    url_fichier = get_url_fichier convertSourate(_num_sourate) , _recitateur, convertFichier (new_fichier_temp)
                    fichier_xml   = url_fichier[1]
                    play_fichier url_fichier ,_fichier_temp + 1, _nb_fichier, _num_sourate, _recitateur, fichier_xml, 0

                    return
              })
              return
        })
        s = soundManager.getSoundById _fichier_temp

      return


player =
  current_marker : null
  current_aya : null
  state : "stop"
  current_file_id : null
  state_auto_play : null
  next : ->

    $(".content_surah_arabic ").removeClass("ayah_playing")
    verset =  $("#ayah_#{this.current_aya}")
    verset.addClass("ayah_playing",{duration:500})
    verset_offset =verset.offset().top
    $('body,html').animate(
      {scrollTop: (verset_offset - 50)+"px"}, {easing: "swing", duration: 1600}
    )
    this.current_aya = parseInt(this.current_aya) + 1

son_exist = (sound_id) =>
  exist = false
  unless player.current_file_id == null
    sound = soundManager.getSoundById player.current_file_id
    unless typeof sound == 'undefined'
      exist = true
  exist

$(document).ready =>
  $("#select_surah").change((e) =>
    $("#frm_surahs").submit()
  )

  $("#select_to_verse").change((e) =>
    $("#select_to_verse_check").val 1
  )

  $("#sidebar-shortcuts-large").on('click','#button_play_surah', (e) =>
    id_surah = $("#select_surah").val()
    from_verset = $("#select_from_verse").val()
    to_verset = $("#select_to_verse").val()
    recitator = $("#select_recitator").val()
    player.current_aya = $("#select_from_verse").val()

    play_recitation id_surah, recitator, from_verset, to_verset

  )