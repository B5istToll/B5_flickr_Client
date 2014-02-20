function validateForm()
{
  var title=document.forms["Form"]["title"].value;
    if (title==null || title=="")
    {
      alert("Title must be filled out");
      return false;
    }

  var file=document.forms["Form"]["pictureLink"].value;
  var error="";
  if (file == 0) { alert ("Please select a picture!"); return false; }

  var Bildarray = file.split(".");
  var Anzahl = Bildarray.length;
  var Endung = Bildarray[Anzahl-1];
  if (Endung != "jpg" && Endung != "JPG" && Endung != "gif" && Endung != "GIF" && Endung != "png" && Endung != "PNG") { alert ("Picture should be jpg, gif or png!"); return false; }

}
