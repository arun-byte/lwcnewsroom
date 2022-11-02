public with sharing class newsController {
    @AuraEnabled
   public static Map<String,Object> retrieveNews(){
    HttpRequest httpRequest = new HttpRequest();
    httpRequest.setEndpoint('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=f66fc3df20e945039e909aeaf79d9c7d');
    httpRequest.setMethod('GET');


    Map<String,Object> newJsonData = new Map<String,Object>();
    String strResponse=null;

    try{
        Http http= new Http();
        HttpResponse httpResponse = http.send(httpRequest);
        if(httpResponse.getStatusCode()==200){
      strResponse=httpResponse.getBody();
        }
        else{
           throw new CalloutException(httpResponse.getBody());
        }
    }catch(Exception e)
    {
        throw e;
    }
if(!String.isBlank(strResponse)){
    newJsonData = (Map<String,Object>)JSON.deserializeUntyped(strResponse);

}
if(!newJsonData.isEmpty()){
    return newJsonData;
}else {
    return null;
}
   }
}
