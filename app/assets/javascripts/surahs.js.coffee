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
      test()
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

  marker = get_the_marker _from_verset, file_of_verset, vlist

  url_fichier = get_url_fichier convertSourate(_id_surah) , _recitator, convertFichier file_of_verset

  fichier_xml = url_fichier[1]
  tab_duration  =  get_time_ayah fichier_xml
  console.log tab_duration

test = () ->
  alert "ok"


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

    play_recitation id_surah, recitator, from_verset, to_verset

  )