String trimString(String text){
  if (text.length>30){
    var trimText = text.substring(0,20) + "...";
    return trimText;
  }
  else {
    return text;
  }
}