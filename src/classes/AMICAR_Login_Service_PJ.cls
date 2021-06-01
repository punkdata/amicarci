public class AMICAR_Login_Service_PJ {
    public static AMICAR_Respuesta_PJ_Simulation envioServicio(string apikey,string metodo,string url, string jsonEnvio ) {
            Http http = new Http();
			HttpRequest request = new HttpRequest();
			HttpResponse response = new HttpResponse();
			request.setTimeout(120000);
            request.setEndpoint(url);
			request.setHeader('Content-Type', 'application/json');
            request.setMethod(metodo);
            request.setHeader('x-api-key',apikey );
            request.setBody(jsonEnvio);
        
       if(!Test.isRunningTest()){  
				response = http.send(request);
			}else{
				response.setStatusCode(200);
				response.setStatus('OK');
				response.setBody('');
			} 
			if (response.getStatusCode() != 200) {
				System.debug('Respuesta : '+response.getBody());
				System.debug('Hubo un problema: ' +
							 response.getStatusCode() + ' ' + response.getStatus());
            
			} else {
				System.debug('Respuesta exitosa: '+response.getBody());
				AMICAR_Respuesta_PJ_Simulation resp = (AMICAR_Respuesta_PJ_Simulation)JSON.deserialize(response.getBody(),AMICAR_Respuesta_PJ_Simulation.class);
				return resp;
			}
			return null;
		} 

    public static string simulacionPj(string apikey,string metodo,string url, string jsonEnvio ) {
			 Http http = new Http();
			HttpRequest request = new HttpRequest();
			HttpResponse response = new HttpResponse();
			request.setTimeout(120000);
            request.setEndpoint(url);
			request.setHeader('Content-Type', 'application/json');
            request.setMethod(metodo);
            request.setHeader('x-api-key',apikey );
            request.setBody(jsonEnvio);
        
       if(!Test.isRunningTest()){  
				response = http.send(request);
			}else{
				response.setStatusCode(200);
				response.setStatus('OK');
				response.setBody('');
			} 
			if (response.getStatusCode() != 200) {
				System.debug('Respuesta : '+response.getBody());
				System.debug('Hubo un problema: ' +
							 response.getStatusCode() + ' ' + response.getStatus());
            
			} else {
				System.debug('Respuesta exitosa: '+response.getBody());
				string Respuesta=String.valueOf(response.getStatusCode());
				System.debug('Respuesta exitosa aqui: ' +
							 response.getStatusCode() + ' ' + response.getStatus());
				return Respuesta;

			}
			return null;
		} 

}