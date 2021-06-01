public class AMICAR_ObtieneSimulacionesPj  {
    
    @InvocableMethod(label='Obtener simulaciones persona Juridica paso 1' description='Obtiene simulaciones desde solicitud de persona Juridica')
    public static List<string> ObtieneSimulacionesPj (List<string> inputParams) {
        Integer retoma;
        String jsonSolicitud,jsonSolicitud2,tipoRegistro;
        
        List<Opportunity> solicitudSalesforce = [SELECT 
                                                 Id,
                                                 OwnerId,
                                                 Name,
                                                 AccountId,
                                                 CloseDate,
                                                 Tipo_de_Veh_culo__c,
                                                 Precio_vehiculo__c,
                                                 toLabel(Marca_vehiculo__c),
                                                 Modelo2__c,
                                                 Pie__c,
                                                 Pie_formula__c,
                                                 Cuotas__c,
                                                 Tipo_de_tasa__c,
                                                 Opcion_inmediata__c,
                                                 Monto_retoma__c,
                                                 Vendedor__c,
                                                 Codigo_Concesionario__c,
                                                 Codigo_Importador__c,
                                                 Local__c,
                                                 Local__r.Codigo_Local__c,
                                                 Local__r.Importador__c,
                                                 Modelo2__r.Name,
                                                 Modelo2__r.Codigo_modelo__c,
                                                 Account.Name,
                                                 Account.LastName,
                                                 Account.FirstName,
                                                 Account.PersonEmail,
                                                 Account.PersonMobilePhone,
                                                 Account.RUT__c,
                                                 Account.RUT__pc,///persona j
                                                 Account.Phone,
                                                 Account.isPersonAccount,
                                                 Owner.RUT_F_I__c,
                                                 Account.Id,
                                                 Version__c,
                                                 Otros_ingresos__c,
                                                 Comuna__c,
                                                 A_o_Veh_culo__c,
                                                 Vendedor__r.RUT__c,
                                                 RecordType.DeveloperName,
                                                 Tipo_de_financiamiento__c
                                                 FROM Opportunity WHERE Id =: inputParams];
        
        System.debug('solicitud->\n'+solicitudSalesforce[0]);
        
        Account cuenta=[SELECT Id, 
                        Name,
                        BillingAddress, 
                        Phone, 
                        LastName,
                        OwnerId, 
                        RUT__c  
                        FROM Account 
                        WHERE Id =: solicitudSalesforce[0].Account.Id
                       ];
        List<Contact> ContactoList=[SELECT Id, AccountId, Name, MailingAddress, Email, Department, Contact_ID__c, Cargo__c,MobilePhone
                                    FROM Contact 
                                    WHERE AccountId =: solicitudSalesforce[0].Account.Id
                                   ];
        System.debug('ContactoList '+ContactoList);
        
        List<Quote> Simulaciones =[SELECT Id, Name, RecordTypeId, OpportunityId, Comisi_n_dealer__c, Tasa__c, Cuotas__c, CAE__c, IsSyncing,
                                   Capital_final__c, Costo_total_cr_dito__c, Fecha_creacion__c, Interes_por_desfase__c, Saldo_precio__c,
                                   Tipo_de_financiamiento__c, Tipo_de_tasa2__c, Total_a_financiar__c, Valor_UF__c, Valor_cuota__c
                                   FROM Quote 
                                   WHERE OpportunityId =: solicitudSalesforce[0].Id
                                   AND IsSyncing = true
                                  ];
        ////cambiar
        List<Modelo_de_vehiculo__c> modeloSolicitud = [SELECT Id,
                                                       Name,
                                                       Codigo_modelo__c 
                                                       FROM Modelo_de_vehiculo__c 
                                                       WHERE Id =: solicitudSalesforce[0].Modelo2__c
                                                      ];
        
        System.debug('cuenta: '+cuenta);
        if (solicitudSalesforce[0].Monto_retoma__c != null){
            retoma = Integer.valueOf(solicitudSalesforce[0].Monto_retoma__c);
        }else{
            retoma = 0;
        }
        
        Integer balance = Integer.valueOf(solicitudSalesforce[0].Precio_vehiculo__c) - Integer.valueOf(solicitudSalesforce[0].Pie__c);
        Integer isPersona = 0;
        if(solicitudSalesforce[0].Account.isPersonAccount){
            isPersona = 1;
        }else{
            isPersona = 2;
        }
        system.debug('fecha john: '+String.valueOf(Datetime.newInstance(solicitudSalesforce[0].CloseDate.year(), solicitudSalesforce[0].CloseDate.month(), solicitudSalesforce[0].CloseDate.day()).format('yyy-MM-dd')));
        
        System.debug('solicitudSalesforce[0].Id '+solicitudSalesforce[0].Id );
        System.debug('solicitudSalesforce[0].Vendedor__r.RUT__c '+solicitudSalesforce[0].Vendedor__r.RUT__c );
        System.debug('solicitudSalesforce[0].Owner.RUT_F_I__c'+solicitudSalesforce[0].Owner.RUT_F_I__c );
        jsonSolicitud = '{\n'+
            '"transactionId": "'+ solicitudSalesforce[0].Id +'",\n'+
            '"sellerIdentificationValue": "'+ solicitudSalesforce[0].Vendedor__r.RUT__c + '",\n'+
            '"amicarExecutiveIdentificationValue": "'+ solicitudSalesforce[0].Owner.RUT_F_I__c + '",\n'+
            '"customer":{\n'+
            '"identificationTypeId": 2,\n'+
            '"identificationValue":  "'+solicitudSalesforce[0].Account.RUT__c +'",\n'+	
            '"contactEmail": "'+ ContactoList[0].Email + '",\n' +
            '"contactPhone": "'+ContactoList[0].MobilePhone+'"\n'+				   
            '},\n'+
            '"vehicle": {\n'+
            '"type": "'+ solicitudSalesforce[0].Tipo_de_Veh_culo__c +'",\n'+
            '"price": '+ Integer.valueOf(solicitudSalesforce[0].Precio_vehiculo__c) +',\n'+
            '"brandName": "'+ solicitudSalesforce[0].Marca_vehiculo__c +'",\n'+
            '"modelName": "'+ solicitudSalesforce[0].Modelo2__r.name + '",\n'+
            '"version": "'+ solicitudSalesforce[0].Version__c +'",\n'+
            '"year": '+ solicitudSalesforce[0].A_o_Veh_culo__c +'\n'+
            '},\n'+
            '"loan": {\n'+
            '"downPayment": '+ Integer.valueOf(solicitudSalesforce[0].Pie__c) + ',\n'+
            '"downPaymentPercentage": '+ Integer.valueOf(solicitudSalesforce[0].Pie_formula__c) + ',\n'+
            '"term": '+ Integer.valueOf(solicitudSalesforce[0].Cuotas__c) + ',\n'+
            '"customerRate": 2 ,\n'+///'+Simulaciones[0].Cuotas__c+'  cambiar 
            '"balance": '+ balance +',\n'+
            '"type": "CONVENTIONAL",\n'+///+Simulaciones[0].Tipo_de_financiamiento__c+  cambiar
            '"startDate": "'+ String.valueOf(System.today()) + '",\n'+
            '"firstDueDate": "'+ Datetime.newInstance(solicitudSalesforce[0].CloseDate.year(), solicitudSalesforce[0].CloseDate.month(), solicitudSalesforce[0].CloseDate.day()).format('yyy-MM-dd') + '",\n'+///////desarrollo el numero de pago 1 lista
            '"rateType": "CONVENTIONAL_NORMAL",\n'+//+Simulaciones[0].Tipo_de_tasa2__c+   cambiar
            '"saleChannel": "'+ solicitudSalesforce[0].Local__r.Importador__c + '",\n'+
            '"saleChannelType": "IMPORTADOR",\n'+///dentro del objeto local (importador ) ////preguntar otra vez 
            '"salesRoomId": '+ Integer.valueOf(solicitudSalesforce[0].Local__r.Codigo_Local__c) + ',\n'+
            '"immediateOption": '+ solicitudSalesforce[0].Opcion_inmediata__c + ',\n'+
            '"tradeInCarValue": '+ retoma +',\n'+
            '"accessories": 0,\n'+///valor no sale pero segun Hector se tiene que quedar porque mas adelante se va usar 9-02-2021
            '"modifyTerm": []\n'+
            '},\n'+
            '"surchargesAndInsurances": {\n'+
            '"amicarAssistance": [],\n'+
            '"financingEntityInsurance": [],\n'+
            '"dealerSurcharges": [],\n'+
            '"financingEntitySurcharges": [],\n'+
            '"dealerInsurance": []\n'+
            '}\n'+
            '}';
        System.debug('json->\n'+jsonSolicitud);
        
        
        
        // llamada a metodo futuro para envio a servicio
        Id id_oportunidad = inputParams[0];
        String tipoDeTasa = solicitudSalesforce[0].Tipo_de_tasa__c;
        
        AMICAR_Integracion__mdt   endpointSolicitudes = [SELECT Id,URL__c,Metodo__c 
                                                         FROM AMICAR_Integracion__mdt 
                                                         WHERE MasterLabel = 'AMICAR_ObtieneSimulacionesPj'
                                                        ];
        AMICAR_Integracion__mdt   endpointSolicitudesAplicacion = [SELECT Id,URL__c,Metodo__c 
                                                                   FROM AMICAR_Integracion__mdt 
                                                                   WHERE MasterLabel = 'AMICAR_ObtieneSimulacionesPJLoan_applica'
                                                                  ];
        string metodo =endpointSolicitudes.Metodo__c;
        string url=endpointSolicitudes.URL__c;
        string url2=endpointSolicitudesAplicacion.URL__c;
        System.debug('endpoint->'+endpointSolicitudes.URL__c);
        
        API_Keys__mdt apkey = [SELECT Id,APK__c
                               FROM API_Keys__mdt
                               WHERE MasterLabel = 'Simulaciones'
                              ];
        string apikey=apkey.APK__c;
        System.debug('apkey->'+apkey);
        envioServicio(apikey,metodo,url,jsonSolicitud,solicitudSalesforce[0].Id,url2);
        
        return null;
    }
    @future(callout=true)
    static void envioServicio(string apikey,string metodo,string url,string jsonSolicitud, string solicitud_ID,string url2){
        system.debug('entro al metodo futuro');
        AMICAR_Respuesta_PJ_Simulation respuesta_Simulador = new AMICAR_Respuesta_PJ_Simulation();
        respuesta_Simulador=AMICAR_Login_Service_PJ.envioServicio(apikey,metodo,url,jsonSolicitud);
        system.debug('respuesta_Simulador'+respuesta_Simulador);
        
        List<Opportunity> solicitudSalesforce = [SELECT 
                                                 Id,
                                                 Direccion__c,
                                                 OwnerId,
                                                 Name,
                                                 AccountId,
                                                 CloseDate,
                                                 Tipo_de_Veh_culo__c,
                                                 Precio_vehiculo__c,
                                                 toLabel(Marca_vehiculo__c),
                                                 Modelo2__c,
                                                 Pie__c,
                                                 Pie_formula__c,
                                                 Cuotas__c,
                                                 Tipo_de_tasa__c,
                                                 Opcion_inmediata__c,
                                                 Monto_retoma__c,
                                                 Vendedor__c,
                                                 Codigo_Concesionario__c,
                                                 Codigo_Importador__c,
                                                 Local__c,
                                                 Local__r.Codigo_Local__c,
                                                 Local__r.Importador__c,
                                                 Modelo2__r.Name,
                                                 Modelo2__r.Codigo_modelo__c,
                                                 Account.Name,
                                                 Account.LastName,
                                                 Account.FirstName,
                                                 Account.PersonEmail,
                                                 Account.PersonMobilePhone,
                                                 Account.RUT__c,
                                                 Account.RUT__pc,///persona j
                                                 Account.Phone,
                                                 Account.isPersonAccount,
                                                 Owner.RUT_F_I__c,
                                                 Account.Id,
                                                 Version__c,
                                                 Regi_n__c,
                                                 Ano__c,
                                                 Otros_egresos__c,
                                                 Descripcion_otros_egresos__c,
                                                 Folio__c,
                                                 Descripcion_otros_ingresos__c,
                                                 Otros_ingresos__c,
                                                 A_o_Veh_culo__c,
                                                 Vendedor__r.RUT__c,
                                                 RecordType.DeveloperName,
                                                 Banco_cuenta_1__c,
                                                 Numero_cuenta_1__c,
                                                 Tipo_cuenta_1__c,
                                                 PAC_cuenta_1__c,
                                                 Banco_cuenta_2__c,
                                                 Numero_cuenta_2__c,
                                                 Tipo_de_cuenta_2__c,
                                                 PAC_cuenta_2__c,
                                                 Comuna__c,
                                                 Codigo_18__c,
                                                 Codigo_25__c,
                                                 Codigo_36__c,
                                                 Codigo_158__c,
                                                 Codigo_170__c,
                                                 Codigo_305__c,
                                                 Codigo_545__c,
                                                 Codigo_611__c,
                                                 Codigo_628__c,
                                                 Codigo_636__c,
                                                 Codigo_641__c,
                                                 Tipo_de_financiamiento__c
                                                 FROM Opportunity WHERE Id =: solicitud_ID];
        Account cuenta=[SELECT Id, 
                        Name,
                        BillingAddress, 
                        Phone, 
                        FirstName,
                        LastName,
                        OwnerId,
                        Description, 
                        RUT__c, 
                        BillingStreet, 
                        BillingCity, 
                        BillingState, 
                        BillingPostalCode, 
                        BillingCountry
                        FROM Account 
                        WHERE Id =: solicitudSalesforce[0].Account.Id
                       ];
        List<Contact> contacto=	[SELECT Id,
                                 Name, 
                                 AccountId,
                                 FirstName,
                                 LastName, 
                                 MailingAddress,
                                 Email,
                                 Department,
                                 MobilePhone, 
                                 Contact_ID__c,
                                 Cargo__c,
                                 Phone 
                                 FROM Contact 
                                 WHERE AccountId =: solicitudSalesforce[0].Account.Id
                                ];
        List<Impuesto__c> declaracionIVA=[SELECT Id, 
                                          Name,
                                          Solicitud__c, 
                                          Fecha__c, 
                                          Impuesto_compras__c, 
                                          Impuesto_ventas__c 
                                          FROM Impuesto__c 
                                          WHERE Solicitud__c =: solicitudSalesforce[0].Id
                                         ];	
        List<Relacion__c> relacionados =[SELECT Id,
                                         Name, 
                                         Nombre__c,
                                         Apellidos__c,
                                         Tipo_de_relacion__c,
                                         Telefono__c,
                                         Solicitud__c,
                                         Cuenta__r.name, 
                                         Comuna__c, 
                                         Cuenta__c,
                                         Direccion__c, 
                                         Estado_civil__c, 
                                         RUT__c, 
                                         Tipo_de_trabajador__c,
                                         Tipo_de_actividad__c,
                                         Sueldo_liquido__c,
                                         RecordType.name,
                                         Regimen_matrimonial__c, 
                                         toLabel(Region__c)
                                         FROM Relacion__c 
                                         WHERE Solicitud__c =: solicitudSalesforce[0].Id
                                        ];	
        list<Patrimonio__c>patrimoniolist =[SELECT Id, 
                                            Name, 
                                            Solicitud__c, 
                                            Descripcion__c, 
                                            Financiamiento__c, 
                                            Tipo__c, 
                                            Valor_venta__c,
                                            Con_deuda__c
                                            FROM Patrimonio__c 
                                            WHERE Solicitud__c =: solicitudSalesforce[0].Id
                                           ];									  
        Integer isPersona = 0;
        if(solicitudSalesforce[0].Account.isPersonAccount){
            isPersona = 1;
        }else{
            isPersona = 2;
        }
        string Description='';
        
        if(cuenta.Description!=null) {
            Description=cuenta.Description;
        }
        Integer Codigo_18=0;
        Integer Codigo_25=0;
        Integer Codigo_36=0;
        Integer Codigo_158=0; 
        Integer Codigo_170=0;
        Integer Codigo_305=0; 
        Integer Codigo_545=0; 
        Integer Codigo_611=0;
        Integer Codigo_628=0; 
        Integer Codigo_636=0;
        Integer Codigo_641=0;
        
        if(solicitudSalesforce[0].Codigo_18__c!=null){
            Codigo_18=Integer.valueOf(solicitudSalesforce[0].Codigo_18__c);
        }
        if(solicitudSalesforce[0].Codigo_25__c!=null){
            Codigo_25=Integer.valueOf(solicitudSalesforce[0].Codigo_25__c);
        }
        if(solicitudSalesforce[0].Codigo_36__c!=null){
            Codigo_36=Integer.valueOf(solicitudSalesforce[0].Codigo_36__c);
        }
        if(solicitudSalesforce[0].Codigo_158__c!=null){
            Codigo_158=Integer.valueOf(solicitudSalesforce[0].Codigo_158__c);
        }
        if(solicitudSalesforce[0].Codigo_170__c!=null){
            Codigo_170=Integer.valueOf(solicitudSalesforce[0].Codigo_170__c);
        }
        if(solicitudSalesforce[0].Codigo_305__c!=null){
            Codigo_305=Integer.valueOf(solicitudSalesforce[0].Codigo_305__c);
        }
        if(solicitudSalesforce[0].Codigo_545__c!=null){
            Codigo_545=Integer.valueOf(solicitudSalesforce[0].Codigo_545__c);
        }
        if(solicitudSalesforce[0].Codigo_611__c!=null){
            Codigo_611=Integer.valueOf(solicitudSalesforce[0].Codigo_611__c);
        }
        if(solicitudSalesforce[0].Codigo_628__c!=null){
            Codigo_628=Integer.valueOf(solicitudSalesforce[0].Codigo_628__c);
        }
        if(solicitudSalesforce[0].Codigo_636__c!=null){
            Codigo_636=Integer.valueOf(solicitudSalesforce[0].Codigo_636__c);
        }
        if(solicitudSalesforce[0].Codigo_641__c!=null){
            Codigo_641=Integer.valueOf(solicitudSalesforce[0].Codigo_641__c);
        }
        
        
        string jsonSolicitud2 = '{\n'+
            '"transactionId": "'+ solicitudSalesforce[0].Id +'",\n'+
            '"simulationId": '+respuesta_Simulador.simulationId+',\n'+
            '"sellerIdentificationValue": "'+ solicitudSalesforce[0].Vendedor__r.RUT__c + '",\n'+
            '"amicarExecutiveIdentificationValue":  "'+ solicitudSalesforce[0].Owner.RUT_F_I__c + '",\n'+
            '"customer": {\n'+
            '"identificationValue": "'+cuenta.RUT__c+'",\n'+
            '"identificationTypeId": '+isPersona+',\n'+
            '"documentSerialNumber": "",\n'+
            '"name": "'+solicitudSalesforce[0].name+'",\n'+
            '"lastName": "'+cuenta.FirstName+'",\n'+
            '"motherLastName": "'+cuenta.LastName+'",\n'+///no sale
            '"email": "'+contacto[0].Email+'",\n'+////preguntar
            '"phone": "'+contacto[0].MobilePhone+'",\n'+////preguntar
            '"address": "'+solicitudSalesforce[0].Direccion__c+', '+solicitudSalesforce[0].Regi_n__c+'",\n'+
            '"dob": "1983-12-19",\n'+///no sale
            '"geographicDataId": "'+solicitudSalesforce[0].Comuna__c+'",\n'+
            '"companyName": "'+cuenta.name+'",\n'+
            '"businessSectorId": "1",\n'+///valor no esta 
            '"businessSectorDescription": "'+Description+'",\n'+
            '"numberOfWorkers": 1,\n'+///valor no esta 
            '"workPhone": "21332",\n'+///valor no esta 
            '"contactName": "'+contacto[0].name+'",\n'+
            '"contactWorkPosition": "'+contacto[0].Cargo__c+'",\n'+
            '"contactPhone": "'+contacto[0].MobilePhone+'",\n'+
            '"contactWorkPhone": "'+contacto[0].Phone+'",\n'+
            '"contactEmail": "'+contacto[0].Email+'"\n'+
            '},\n'+
            '"customerRequestData": {\n'+ //estos valores no estan 
            '"maritalStatus": "SO",\n'+
            '"maritalRegime": "NA",\n'+
            '"academicLevel": "SU",\n'+
            '"livingHousehold": "3",\n'+
            '"profession": "Médico",\n'+
            '"generalComments": "Esta solicitud necesita ser revisada con urgencia."\n'+
            '},\n'+
            '"income": {\n'+
            '"salary": 100,\n'+////No tiene una persona juridica 
            '"honorarium": 1,\n'+//No tiene una persona juridica 
            '"retirementSalary": 2,\n'+//No tiene una persona juridica 
            '"pensionSalary": 3,\n'+//No tiene una persona juridica 
            '"rentalIncome": 4,\n'+
            '"otherIncome": '+integer.valueof(solicitudSalesforce[0].Otros_ingresos__c)+',\n'+
            '"descriptionForOtherIncome": "'+solicitudSalesforce[0].Descripcion_otros_ingresos__c+'"\n'+
            '},\n'+
            '"otherIncome": {\n'+ ///solicitud declaracion de renta 
            '"year": '+integer.valueof(solicitudSalesforce[0].Ano__c)+',\n'+
            '"folioNumber": '+integer.valueof(solicitudSalesforce[0].Folio__c)+',\n'+
            '"code18": '+Codigo_18+',\n'+///preguntar 
            '"code25": '+Codigo_25+',\n'+
            '"code36": '+Codigo_36+',\n'+
            '"code158": '+Codigo_158+',\n'+
            '"code170": '+Codigo_170+',\n'+
            '"code305": '+Codigo_305+',\n'+
            '"code461": '+Codigo_641+',\n'+////valor no esta en salesforce esta invertido 
            '"code545": '+Codigo_545+',\n'+
            '"code611": '+Codigo_611+',\n'+
            '"code628": '+Codigo_628+',\n'+
            '"code636": '+Codigo_636+'\n'+
            '},\n'+
            '"expenses": {\n'+ 
            '"mortgageCost": 200,\n'+///preguntar no sale
            '"otherFixedExpenses": '+integer.valueof(solicitudSalesforce[0].Otros_egresos__c)+'\n'+
            '},\n'+
            // '"taxReturn": [\n'+/// objeto relacionado a la solicitud declaracion de iva 
            '"taxReturn": [\n';/// objeto relacionado a la solicitud declaracion de iva 
        
        if(declaracionIVA.size()>0){
            for(integer i=0;i<declaracionIVA.size();i++){
                jsonSolicitud2+= '{\n'+
                    '"dateTax": "'+declaracionIVA[i].Fecha__c.year() +'-'+ declaracionIVA[i].Fecha__c.month()+'",\n'+  
                    '"purchaseTax": '+Integer.valueOf(declaracionIVA[i].Impuesto_compras__c)+',\n'+////impuesto compra 
                    '"salesTax": '+Integer.valueOf(declaracionIVA[i].Impuesto_ventas__c)+'\n'+ //impuesto venta 
                    '}\n';
                if(i!=(declaracionIVA.size()-1)){
                    jsonSolicitud2+=',';               
                }
            }
        }
        
        jsonSolicitud2+='],\n'+
            '"buyForAnother": {\n';
        /// (objeto relacionados) del tipo de registro compra para 
        
        for(Integer i=0; i<relacionados.size();i++){
            if(relacionados[i].RecordType.Name=='Compra para'){
                
                jsonSolicitud2+='"identificationTypeId": 1,\n'+///relacionados[i].id    valor alfanumerico
                    '"identificationValue": "10725269k",\n'+////relacionados[i].RUT__c   dice que el rut no es valido 
                    '"name": "'+relacionados[i].name+'",\n'+
                    '"lastName": "Pérez",\n'+///solo nombre no permite vacio 
                    '"motherLastName": "López",\n'+///solo nombre no permite vacio 
                    '"address": "'+relacionados[i].Direccion__c+', '+relacionados[i].Region__c+'",\n'+
                    '"geographicDataId": "'+relacionados[i].Comuna__c+'",\n'+
                    '"dob": "1984-11-29",\n'+////sera la fecha de creacion del registro 
                    '"nationalityId": "CHILE",\n'+//no se tiene este valor 
                    '"maritalStatus": "'+relacionados[i].Estado_civil__c+'",\n'+
                    '"maritalRegime": "'+relacionados[i].Regimen_matrimonial__c+'"\n'+
                    '},\n';
            }
        }
        for(Integer i=0; i<relacionados.size();i++){
            if(relacionados[i].RecordType.Name=='Aval'){
                jsonSolicitud2+='"guarantor": [\n'+
                    '{\n'+/// (objeto relacionados) del tipo de registro aval 
                    '"identificationTypeId": 1,\n'+////relacionados[i].id    valor alfanumerico
                    '"identificationValue": "10725269k",\n'+////relacionados[i].RUT__c
                    '"name": "'+relacionados[i].Name+'",\n'+
                    '"lastName": "Pérez",\n'+///no tinen
                    '"motherLastName": "López",\n'+///no tinen
                    '"address": "'+relacionados[i].Direccion__c+', '+relacionados[i].Region__c+'",\n'+
                    '"geographicDataId": "'+relacionados[i].Comuna__c+'",\n'+
                    '"dob": "1984-11-29",\n'+///sera la fecha de creacion 
                    '"nationalityId": "CHILE",\n'+///no se tiene este valor 
                    '"maritalStatus": "'+relacionados[i].Estado_civil__c+'",\n'+
                    '"maritalRegime": "'+relacionados[i].Regimen_matrimonial__c+'",\n'+
                    '"workType":  "'+relacionados[i].Tipo_de_trabajador__c+'",\n'+
                    '"activityTypeId":  "'+relacionados[i].Tipo_de_actividad__c+'",\n'+
                    '"salary": '+relacionados[i].Sueldo_liquido__c+',\n'+
                    '"email": "asasa@sdsd.com"\n'+/////este valor no esta 
                    '}\n';
            }
        }
        
        jsonSolicitud2+='],\n'+
            '"bankInformation": [\n'+////informacion bancaria de la solicitud 
            '{\n'+
            '"codeId": "'+solicitudSalesforce[0].Banco_cuenta_1__c+'",\n'+
            '"automaticPayment": '+solicitudSalesforce[0].PAC_cuenta_1__c+',\n'+
            '"accountNumber": "'+solicitudSalesforce[0].Numero_cuenta_1__c+'"\n'+
            '}\n';
        if(solicitudSalesforce[0].Banco_cuenta_2__c != null){
            jsonSolicitud2+=',{\n'+
                '"codeId": "'+solicitudSalesforce[0].Banco_cuenta_2__c+'",\n'+
                '"automaticPayment":'+solicitudSalesforce[0].PAC_cuenta_2__c+',\n'+
                '"accountNumber": "'+solicitudSalesforce[0].Numero_cuenta_2__c+'"\n'+
                '}\n';
        }
        
        jsonSolicitud2+=' ],\n'+
            '"heritage": [\n';////patrimonio  validar estructura 
        if(patrimoniolist.size()>0){
            for(Integer i=0; i<patrimoniolist.size();i++){
                jsonSolicitud2+='{\n'+
                    '"type": "'+patrimoniolist[i].Tipo__c+'",\n'+
                    '"description": "'+patrimoniolist[i].Descripcion__c+'",\n'+
                    '"saleValue": '+patrimoniolist[i].Valor_venta__c +',\n'+
                    '"financing": "'+patrimoniolist[i].Financiamiento__c+'",\n'+
                    '"stillPaying": '+patrimoniolist[i].Con_deuda__c+'\n'+
                    '}\n';
                
                if(i!=(patrimoniolist.size()-1)){
                    jsonSolicitud2+=',';               
                }
            }
        }
        else{////por si hay algun error 
            jsonSolicitud2+='{\n'+
                '"type": "BR",\n'+
                '"description": "Casa Guatire",\n'+
                '"saleValue": 145000000,\n'+
                '"financing": "2",\n'+
                '"stillPaying": true\n'+
                '}\n';
        }
        jsonSolicitud2+= '],\n'+
            '"personalReferences": [\n'; /// (objeto relacionados) del tipo de registro referencias  
        
        for(Integer i=0; i<relacionados.size();i++){
            if(relacionados[i].RecordType.Name=='Referencia'){
                jsonSolicitud2+='{\n'+
                    '"name": "'+relacionados[i].Nombre__c+'",\n'+
                    '"type": "'+relacionados[i].Tipo_de_relacion__c+'",\n'+
                    '"address": "'+relacionados[i].Direccion__c+'",\n'+
                    '"phone": "'+relacionados[i].Telefono__c+'"\n'+ 
                    '}\n';
            }
        }
        jsonSolicitud2+='],\n'+
            '"customerSuppliers": [\n'+///////esto no esta en salesforce
            '{\n'+
            '"name": "Manuel",\n'+
            '"phone": "544554",\n'+
            '"relationship": "test"\n'+
            '}\n'+
            '],\n';
        jsonSolicitud2+='"legalRepresentative": [\n'; /// (objeto relacionados) del tipo de registro representante legal   
        for(Integer i=0; i<relacionados.size();i++){
            if(relacionados[i].RecordType.Name=='Representante Legal'){
                jsonSolicitud2+='{\n'+
                    '"identificationValue": "'+relacionados[i].id+'",\n'+
                    '"name": "'+relacionados[i].Cuenta__r.Name+'",\n'+
                    '"address": "'+relacionados[i].Direccion__c+', '+relacionados[i].Region__c+'",\n'+
                    '"email": "",\n'+///son datos de la cuenta?
                    '"phone": "",\n'+///son datos de la cuenta?
                    '"activityTypeId": "'+relacionados[i].Tipo_de_actividad__c+'",\n'+
                    '"geographicDataId": "'+relacionados[i].Comuna__c+'",\n'+
                    '"isGuarantor": true,\n'+/////no sale en este tipo de registo 
                    '"maritalStatus": "'+relacionados[i].Estado_civil__c+'"\n'+
                    '}\n';
            }
        }	
        jsonSolicitud2+= '],\n'+
            '"majorityPartners": [\n';/// (objeto relacionados) del tipo de registro representante socios  
        for(Integer i=0; i<relacionados.size();i++){ 
            if(relacionados[i].RecordType.Name=='Socio'){
                jsonSolicitud2+='{\n'+
                    '"identificationValue": "'+relacionados[i].id+'",\n'+
                    '"name": "'+relacionados[i].Cuenta__r.Name+'",\n'+
                    '"address": "'+relacionados[i].Direccion__c+', '+relacionados[i].Region__c+'",\n'+
                    '"phone": "",\n'+/////este valor es de la cuenta
                    '"profession": "asaas",\n'+///////este valor no esta en salesforce 
                    '"houseAppraisal": 1211212,\n'+//este valor no esta en salesforce 
                    '"vehicleAppraisal": 1212,\n'+//este valor no esta en salesforce 
                    '"participationPercentage": 15\n'+//este valor no esta en salesforce 
                    '}\n';
                
            }
        }
        
        jsonSolicitud2+='],\n'+
            '"surchargesAndInsurances": {\n'+/////producto adicionales segun familia 
            '"amicarAssistance": [],\n'+
            '"dealerSurcharges": [\n';
        for(Integer i=0; i<respuesta_Simulador.surchargesAndInsurances.dealerSurcharges.size();i++){
            jsonSolicitud2+='{\n'+
                '"id":'+respuesta_Simulador.surchargesAndInsurances.dealerSurcharges[i].id+',\n'+
                '"description": "'+respuesta_Simulador.surchargesAndInsurances.dealerSurcharges[i].description+'",\n'+
                '"value": '+respuesta_Simulador.surchargesAndInsurances.dealerSurcharges[i].value+',\n'+
                '"isEditable": '+respuesta_Simulador.surchargesAndInsurances.dealerSurcharges[i].isEditable+',\n'+
                '"currencyType": "'+respuesta_Simulador.surchargesAndInsurances.dealerSurcharges[i].currencyType+'",\n'+
                '"factorCalculated": '+respuesta_Simulador.surchargesAndInsurances.dealerSurcharges[i].factorCalculated+',\n'+
                '"selected": '+respuesta_Simulador.surchargesAndInsurances.dealerSurcharges[i].selected+',\n'+
                '"isRequired": '+respuesta_Simulador.surchargesAndInsurances.dealerSurcharges[i].isRequired+'\n'+
                '}\n';
            if(i!=(respuesta_Simulador.surchargesAndInsurances.dealerSurcharges.size()-1)){
                jsonSolicitud2+=',';               
            }
        }
        
        jsonSolicitud2+='],\n'+
            '"dealerInsurance": [],\n'+
            '"financingEntitySurcharges": [\n';
        for(Integer i=0; i<respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges.size();i++){
            jsonSolicitud2+='{\n'+
                '"id": '+respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges[i].id+',\n'+
                '"description": "'+respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges[i].description+'",\n'+
                '"value": '+respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges[i].value+',\n'+
                '"isEditable": '+respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges[i].isEditable+',\n'+
                '"currencyType": "'+respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges[i].currencyType+'",\n'+
                '"factorCalculated": '+respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges[i].factorCalculated+',\n'+
                '"selected": '+respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges[i].selected+',\n'+
                '"isRequired": '+respuesta_Simulador.surchargesAndInsurances.financingEntitySurcharges[i].isRequired+'\n'+
                '}\n'+
                '],\n';
        }
        jsonSolicitud2+='"financingEntityInsurance": [\n';
        for(Integer i=0; i<respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance.size();i++){
            jsonSolicitud2+='{\n'+
                '"id": '+respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance[i].id+',\n'+
                '"description": "'+respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance[i].description+'",\n'+
                '"value": '+respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance[i].value+',\n'+
                '"currencyType": "'+respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance[i].currencyType+'",\n'+
                '"factorCalculated": '+respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance[i].factorCalculated+',\n'+
                '"selected": '+respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance[i].selected+',\n'+
                '"isRequired": '+respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance[i].isRequired+',\n'+
                '"insuranceType": "'+respuesta_Simulador.surchargesAndInsurances.financingEntityInsurance[i].insuranceType+'"\n'+
                '}\n'+
                ']\n';
        }
        jsonSolicitud2+= '}\n'+
            '}';
        System.debug('json->\n'+jsonSolicitud2);
        string respuesta= AMICAR_Login_Service_PJ.simulacionPj(apikey,metodo,url2,jsonSolicitud2);
        System.debug('respuesta'+respuesta);
        ////lógica de creación de información 
        String tipoDeTasa = solicitudSalesforce[0].Tipo_de_tasa__c;
        String resultadoServcio;
        if (respuesta == '200' ){
            
            List<Quote> eliminarEscenarios = [SELECT Id 
                                              FROM Quote 
                                              WHERE OpportunityId =: solicitudSalesforce[0].id
                                             ];
            if (eliminarEscenarios.size() != 0 && !Test.isRunningTest()){
                delete eliminarEscenarios;
            }
             
            resultadoServcio='['+json.serialize(respuesta_Simulador)+']';
            string solicitudMetodo  =solicitudSalesforce[0].id;
            //
            // servicio responde OK, analizamos la respuesta
            //----------------------------------------------------------------------------------
            procesoRespuestaServicio(resultadoServcio,solicitudMetodo,tipoDeTasa,solicitudSalesforce[0].RecordType.DeveloperName);
            
            resultadoServcio = 'OK';
            
        }
        else{
            
            //
            // servicio responde NOK, guardamos la respuesta en la solicitud
            //----------------------------------------------------------------------------------
            
            
            resultadoServcio = 'Mensaje: '+ respuesta;
        }
        
        Opportunity updOportunidad = [SELECT Id,Respuesta_Servicio__c 
                                      FROM Opportunity 
                                      WHERE Id =: solicitudSalesforce[0].id
                                     ];
        
        updOportunidad.Respuesta_Servicio__c = resultadoServcio;
        update updOportunidad;
    } 
 
        
        
    public static void procesoRespuestaServicio(String respuestaMetodo,string solicitudMetodoid,String tasaMetodo,String registroMetodo){
        System.debug('respuestaMetodo-->'+respuestaMetodo);
            List<AMICAR_Respuesta_PJ_Simulation> respuestaSimulacion = (List<AMICAR_Respuesta_PJ_Simulation>) 
                Json.deserialize(respuestaMetodo, List<AMICAR_Respuesta_PJ_Simulation>.class);
            
        System.debug('respuesta simulacion->'+respuestaSimulacion);
        System.debug('tipo de tasa->'+tasaMetodo);
        System.debug('registro->'+registroMetodo);
            List<Desarrollo__c> nuevoDesarrollo = new List<Desarrollo__c>();
        
        Pricebook2 IdListaPrecios;
        if (!Test.isRunningTest()){
            IdListaPrecios = [SELECT Id 
                                FROM Pricebook2 
                               WHERE IsStandard = true
                             ];
        }else{
            Pricebook2 standardPricebook = new Pricebook2(
                Id = Test.getStandardPricebookId(),
                IsActive = true
            );
            update standardPricebook;
            IdListaPrecios = [SELECT Id 
                                FROM Pricebook2 
                               WHERE Id = :standardPricebook.Id
                             ];
        }

        Id rt;
       /* if (registroMetodo == 'Simulacion_CORE'){
            rt = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Simulación CORE').getRecordTypeId();
        }else{
            rt = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Presupuesto Renovaciones').getRecordTypeId();
        }*/
     //for(AMICAR_Respuesta_PJ_Simulation.cls_dealerSurcharges familia :respuesta_Simulador.surchargesAndInsurances.dealerSurcharges  ){
        for (AMICAR_Respuesta_PJ_Simulation respuestas: respuestaSimulacion){

            System.debug('respuesta->'+respuestas);

            Quote cotizacion = new Quote();

         //   cotizacion.RecordTypeId = rt;
            cotizacion.Name = 'simulacion ' + respuestas.FinalLoanValues.loanType + ' ' + respuestas.FinalLoanValues.term;
            cotizacion.OpportunityId = solicitudMetodoid;
            cotizacion.Status = 'Borrador';

            cotizacion.CAE__c = respuestas.EquivalentAnnualCharge.annualCae;
            cotizacion.Costo_total_cr_dito__c = respuestas.EquivalentAnnualCharge.totalLoanCost;
            cotizacion.Valor_UF__c = respuestas.FinalLoanValues.UFValue;
            cotizacion.Saldo_precio__c = respuestas.FinalLoanValues.balance;
            cotizacion.Total_a_financiar__c = respuestas.FinalLoanValues.totalToFinance;
            cotizacion.Interes_por_desfase__c = respuestas.FinalLoanValues.delayedInterest;
            cotizacion.Capital_final__c = respuestas.FinalLoanValues.finalCapital;
            cotizacion.Tipo_de_financiamiento__c = respuestas.FinalLoanValues.loanType;
            cotizacion.Cuotas__c = respuestas.FinalLoanValues.term;
            cotizacion.Valor_cuota__c = respuestas.FinalLoanValues.monthlyPayment;
            cotizacion.Tasa__c = respuestas.FinalLoanValues.customerRate;
            cotizacion.Tipo_de_Tasa2__c = respuestas.FinalLoanValues.rateType;
            cotizacion.Pricebook2Id = IdListaPrecios.Id;
            cotizacion.Comisi_n_dealer__c = respuestas.FinalLoanValues.dealerCommission;
            cotizacion.Fecha_creacion__c = System.now();
            cotizacion.Tasa_dealer__c = respuestas.FinalLoanValues.dealerRate;
			
			System.debug('CUOTAS = '+respuestas.amortizationSchedule);
			//Se agrega VFMG
			for(AMICAR_Respuesta_PJ_Simulation.cls_amortizationSchedule amrtSch : respuestas.amortizationSchedule){
				System.debug('TIPO DE CUOTA = '+ amrtSch.quotaType); 
				if(amrtSch.quotaType == 'SMART'){
      				System.debug('ES SMART');
					System.debug('VFMG = '+amrtSch.payment);
					cotizacion.VFMG__c = amrtSch.payment;
      				break;
				}
			}
			//Fin VFMG
            System.debug('quote->'+cotizacion);
            insert cotizacion;

            //
            // tabla de desarrollo
            //----------------------------------------------------------------------------------
            for (AMICAR_Respuesta_PJ_Simulation.cls_amortizationSchedule desarrollo:respuestas.amortizationSchedule){

                // Generación de registros en tabla "Desarrollo"
                Desarrollo__c cuota = new Desarrollo__c();
                cuota.Numero_de_pago__c = desarrollo.paymentNumber;
                cuota.Simulacion__c = cotizacion.Id;
                cuota.Pago__c = desarrollo.payment;
                cuota.Fecha_vencimiento__c = desarrollo.expirationDate;
                System.debug('tipo cuota->'+desarrollo.quotaType);
                if (desarrollo.quotaType == 'MODIFIED'){
                    cuota.Modificado__c = true;
                }else{
                    cuota.Modificado__c = false;
                }
                //cuota.Solicitud__c = solicitudId;
                nuevoDesarrollo.add(cuota);
            }
            upsert nuevoDesarrollo;

            //
            //recargos y asistencias
            //----------------------------------------------------------------------------------
            //AMICAR_Respuesta_PJ_Simulation.cls_amortizationSchedule
            AMICAR_Respuesta_PJ_Simulation.cls_surchargesAndInsurances recargosyasistencias;
            recargosyasistencias = respuestas.surchargesAndInsurances;

			//RL - Revisar si existen los Productos y Listas de Precios en Salesforce
			checkProductsAndPricebookentries(recargosyasistencias);

            System.debug('recargos->'+recargosyasistencias);

            List<QuoteLineItem> asistenciasAmicarSimulacion = new List<QuoteLineItem>();
            List<QuoteLineItem> recargosDealerSimulacion = new List<QuoteLineItem>();
            List<QuoteLineItem> recargosEfSimulacion = new List<QuoteLineItem>();
            List<QuoteLineItem> segurosDealerSimulacion = new List<QuoteLineItem>();
            List<QuoteLineItem> segurosEfSimulacion = new List<QuoteLineItem>();

            List<Product2> ListaProductos = [SELECT Identificador__c,Id,Family 
                                             FROM Product2 
                                             WHERE IsActive = true 
                                             AND (Family    = 'amicarAssistance'
                                                  OR Family = 'dealerSurcharges'
                                                  OR Family = 'financingEntityInsurance' 
                                                  OR Family = 'dealerInsurance'
                                                  OR Family = 'financingEntitySurcharges')
                                            ];
            Map<String,Id> MapaAsistencias = new Map<String,Id>();

            List<PricebookEntry> ListaEntradas = [SELECT Id,Product2Id 
                                                  FROM PricebookEntry 
                                                  WHERE IsActive = true 
                                                  AND (Product2.Family    = 'amicarAssistance' 
                                                       OR Product2.Family = 'dealerSurcharges' 
                                                       OR Product2.Family = 'financingEntityInsurance' 
                                                       OR Product2.Family = 'dealerInsurance' 
                                                       OR Product2.Family = 'financingEntitySurcharges')
                                                 ];
            Map<Id,Id> MapaEntradas = new Map<Id,Id>();

            if (!ListaEntradas.isEmpty()){

                for (PricebookEntry ProductosEntrada:ListaEntradas){
                        MapaEntradas.put(ProductosEntrada.Product2Id,ProductosEntrada.Id);
                }
            }
            System.debug('mapa entradas->'+MapaEntradas);


            if (!ListaProductos.isEmpty()){

                //
                // productos amicarAssistance
                //----------------------------------------------------------------------------------
                for (Product2 ProductosEnLista:ListaProductos){
                    if (ProductosEnLista.Family == 'amicarAssistance'){
                        MapaAsistencias.put(ProductosEnLista.Identificador__c, ProductosEnLista.Id);
                    }
                }
                System.debug('mapa asistencias amicar->'+MapaAsistencias);

               /* if (!MapaAsistencias.isEmpty()){
                    for (AMICAR_Respuesta_PJ_Simulation.cls_amicarAssistance asistenciasAmicar:recargosyasistencias.amicarAssistance){
                        String clave = asistenciasAmicar.description + ' ' + asistenciasAmicar.id + ' amicarAssistance';
                        System.debug('clave->'+clave);

                        QuoteLineItem nuevoItem = new QuoteLineItem();
                        nuevoItem.Product2Id = MapaAsistencias.get(clave);
                        nuevoItem.Quantity = 1;
                        nuevoItem.UnitPrice = asistenciasAmicar.factorCalculated;
						//Según definición de Patricio Anabalón se debe pegar el value como factorCalculated
						//nuevoItem.Value__c = asistenciasAmicar.value;
						nuevoItem.Value__c = asistenciasAmicar.factorCalculated;
                        nuevoItem.Divisa__c = asistenciasAmicar.currencyType;
                        nuevoItem.QuoteId = cotizacion.Id;
                        nuevoItem.PricebookEntryId = MapaEntradas.get(nuevoItem.Product2Id);

                        nuevoItem.Requerido__c = asistenciasAmicar.isRequired;
                        nuevoItem.Seleccionado__c = asistenciasAmicar.selected;
                        //AGREGADO POR MJ PARA QUE NO SE CAIGA SI NO ENCUENTRA EL PRODUCTO
                        if(nuevoItem.Product2Id != null){
                            asistenciasAmicarSimulacion.add(nuevoItem);
                        }
                        
                    }
                }*/

                System.debug('asistencias amicar->'+asistenciasAmicarSimulacion);
                if (!asistenciasAmicarSimulacion.isEmpty()){
                    insert asistenciasAmicarSimulacion;
                }

                MapaAsistencias.clear();

                //
                //dealerSurcharges
                //----------------------------------------------------------------------------------
                for (Product2 ProductosEnLista:ListaProductos){
                    if (ProductosEnLista.Family == 'dealerSurcharges'){
                        MapaAsistencias.put(ProductosEnLista.Identificador__c, ProductosEnLista.Id);
                    }
                }
                System.debug('mapa recargos dealer->'+MapaAsistencias);
                
                if (!MapaAsistencias.isEmpty()){
                    for (AMICAR_Respuesta_PJ_Simulation.cls_dealerSurcharges recargosDealer:recargosyasistencias.dealerSurcharges){
                        String clave = recargosDealer.description + ' ' + recargosDealer.id + ' dealerSurcharges';
                        System.debug('clave->'+clave);
                        
                        QuoteLineItem nuevoItem = new QuoteLineItem();
                        nuevoItem.Product2Id = MapaAsistencias.get(clave);
                        nuevoItem.Quantity = 1;
                        nuevoItem.UnitPrice = recargosDealer.factorCalculated;
                        //Según definición de Patricio Anabalón se debe pegar el value como factorCalculated
                        //nuevoItem.Value__c = recargosDealer.value;
                        nuevoItem.Value__c = recargosDealer.factorCalculated;
                        nuevoItem.Divisa__c = recargosDealer.currencyType;
                        nuevoItem.QuoteId = cotizacion.Id;
                        nuevoItem.PricebookEntryId = MapaEntradas.get(nuevoItem.Product2Id);
                        
                        nuevoItem.Editable__c = recargosDealer.isEditable;
                        nuevoItem.Requerido__c = recargosDealer.isRequired;
                        nuevoItem.Seleccionado__c = recargosDealer.selected;
                        //AGREGADO POR MJ PARA QUE NO SE CAIGA SI NO ENCUENTRA EL PRODUCTO
                        if(nuevoItem.Product2Id != null){
                            recargosDealerSimulacion.add(nuevoItem);
                        }
                    }
                }
                
                System.debug('recargos dealer->'+recargosDealerSimulacion);
                if (!recargosDealerSimulacion.isEmpty()){
                    insert recargosDealerSimulacion;
                }
                
                MapaAsistencias.clear();
                
                //
                //financingEntitySurcharges
                //----------------------------------------------------------------------------------
                for (Product2 ProductosEnLista:ListaProductos){
                    if (ProductosEnLista.Family == 'financingEntitySurcharges'){
                        MapaAsistencias.put(ProductosEnLista.Identificador__c, ProductosEnLista.Id);
                    }
                }
                System.debug('mapa recargos EF->'+MapaAsistencias);
                
                if (!MapaAsistencias.isEmpty()){
                    for (AMICAR_Respuesta_PJ_Simulation.cls_dealerSurcharges recargosEf:recargosyasistencias.DealerSurcharges){
                        String clave = recargosEf.description + ' ' + recargosEf.id + ' financingEntitySurcharges';
                        System.debug('clave->'+clave);
                        
                        QuoteLineItem nuevoItem = new QuoteLineItem();
                        nuevoItem.Product2Id = MapaAsistencias.get(clave);
                        nuevoItem.Quantity = 1;
                        nuevoItem.UnitPrice = recargosEf.factorCalculated;
                        //Según definición de Patricio Anabalón se debe pegar el value como factorCalculated
                        //nuevoItem.Value__c = recargosEf.value;
                        nuevoItem.Value__c = recargosEf.factorCalculated;
                        nuevoItem.QuoteId = cotizacion.Id;
                        nuevoItem.Divisa__c = recargosEf.currencyType;
                        nuevoItem.PricebookEntryId = MapaEntradas.get(nuevoItem.Product2Id);
                        
                        nuevoItem.Editable__c = recargosEf.IsEditable;
                        nuevoItem.Requerido__c = recargosEf.isRequired;
                        nuevoItem.Seleccionado__c = recargosEf.selected;
                        //AGREGADO POR MJ PARA QUE NO SE CAIGA SI NO ENCUENTRA EL PRODUCTO
                        if(nuevoItem.Product2Id != null){
                            recargosEfSimulacion.add(nuevoItem);
                        }
                    }
                    
                    System.debug('recargos dealer->'+recargosEfSimulacion);
                    if (!recargosEfSimulacion.isEmpty()){
                        insert recargosEfSimulacion;
                    }
                    
                }
                MapaAsistencias.clear();

                //
                //dealerInsurance 
                //----------------------------------------------------------------------------------
                //for (Product2 ProductosEnLista:ListaProductos){
                //  if (ProductosEnLista.Family == 'segurosDealerSimulacion'){
                //      MapaAsistencias.put(ProductosEnLista.Identificador__c, ProductosEnLista.Id);
                //  }
                //}
                //System.debug('mapa seguros dealer->'+MapaAsistencias);

                //if (!MapaAsistencias.isEmpty()){
                //for (AMICAR_Resp_Simulacion_WSJson.DealerInsurance segurosDealer:recargosyasistencias.DealerInsurance){
                //}
                //}

                //System.debug('recargos dealer->'+segurosDealerSimulacion);
                ////insert segurosDealerSimulacion;

                //MapaAsistencias.clear();


                //
                //financingEntityInsurance
                //----------------------------------------------------------------------------------
                for (Product2 ProductosEnLista:ListaProductos){
                    if (ProductosEnLista.Family == 'financingEntityInsurance'){
                        MapaAsistencias.put(ProductosEnLista.Identificador__c, ProductosEnLista.Id);
                    }
                }
                System.debug('mapa seguros segurosEF->'+MapaAsistencias);

                if (!MapaAsistencias.isEmpty()){
                    for (AMICAR_Respuesta_PJ_Simulation.cls_financingEntityInsurance segurosEF:recargosyasistencias.FinancingEntityInsurance){
                        String clave = segurosEF.description + ' ' + segurosEF.id + ' financingEntityInsurance';
                        System.debug('clave->'+clave);

                        System.debug('ef->'+segurosEF);

                        QuoteLineItem nuevoItem = new QuoteLineItem();
                        nuevoItem.Product2Id = MapaAsistencias.get(clave);
                        nuevoItem.Quantity = 1;
                        nuevoItem.UnitPrice = segurosEF.factorCalculated;
						//Según definición de Patricio Anabalón se debe pegar el value como factorCalculated
						//nuevoItem.Value__c = segurosEF.value;
						nuevoItem.Value__c = segurosEF.factorCalculated;
                        nuevoItem.Divisa__c = segurosEF.currencyType;
                        nuevoItem.QuoteId = cotizacion.Id;
                        nuevoItem.PricebookEntryId = MapaEntradas.get(nuevoItem.Product2Id);

                        nuevoItem.Editable__c = false;
                        nuevoItem.Requerido__c = segurosEF.isRequired;
                        nuevoItem.Seleccionado__c = segurosEF.selected;
                        //AGREGADO POR MJ PARA QUE NO SE CAIGA SI NO ENCUENTRA EL PRODUCTO
                        if(nuevoItem.Product2Id != null){
                            segurosEfSimulacion.add(nuevoItem);
                        }
                    }

                    System.debug('seguros EF->'+segurosEfSimulacion);
                    if (!segurosEfSimulacion.isEmpty()){
                        insert segurosEfSimulacion;
                    }
                }

                MapaAsistencias.clear();
            }
        }
    }    

 public Static void checkProductsAndPricebookentries(AMICAR_Respuesta_PJ_Simulation.cls_surchargesAndInsurances jsonR){
        try{
            List<Product2> prodToAdd                            = new List<Product2>();
            List<PricebookEntry> priceToAdd                     = new List<PricebookEntry>();
            List<String> productosJsonAmicarAssistance          = new List<String>();
            List<String> productosJsonFinancingEntityInsurance  = new List<String>();
            List<String> productosJsonDealerSurcharges          = new List<String>();
            List<String> productosJsonDealerInsurance           = new List<String>();
            List<String> productosJsonFinancingEntitySurcharges = new List<String>();
            List<String> familias                               = new List<String>();
            familias.add('amicarAssistance');
            familias.add('financingEntityInsurance');
            familias.add('dealerSurcharges');
            familias.add('dealerInsurance');
            familias.add('financingEntitySurcharges');
            List<Product2> prod2List = [SELECT Identificador__c,Id,Family 
                                          FROM Product2 
                                         WHERE IsActive = true 
                                           AND Family IN : familias];
            List<PricebookEntry> pricebookList = [SELECT Id,Product2Id 
                                                    FROM PricebookEntry 
                                                   WHERE IsActive = true 
                                                     AND Product2.Family IN : familias
                                                 ];
            Map<String,Id> mapProducts = new Map<String,Id>();
            Map<Id,Id> mapPricebooks   = new Map<Id,Id>();
            if(prod2List.size() > 0){
                for(Product2 prod2 : prod2List){
                    mapProducts.put(prod2.Identificador__c, prod2.Id);
                }
            } 
            if(pricebookList.size() > 0){
                for(PricebookEntry ProductosEntrada:pricebookList){
                    mapPricebooks.put(ProductosEntrada.Product2Id,ProductosEntrada.Id);
                }
            }
            //revisar si no existen productos amicarAssistance
            for(AMICAR_Respuesta_PJ_Simulation.cls_dealerSurcharges familia :jsonR.dealerSurcharges  ){
                String clave = familia.description + ' ' + familia.id + ' amicarAssistance';
                productosJsonAmicarAssistance.add(clave);
                String idProductSF = mapProducts.get(clave);
                //Si no existe producto, agregarlo en lista
                if(String.isBlank(idProductSF)){
                    System.debug('No existe, crear '+clave);
                    Product2 prod2 = new Product2();
                    prod2.Name = familia.description;
                    prod2.Family = 'amicarAssistance';
                    prod2.Identificador__c = clave;
                    prod2.IsActive = true;
                    prod2.ProductCode = String.valueOf(familia.id);
                    prodToAdd.add(prod2);
                }
            }  
            //revisar si no existen productos financingEntityInsurance
            for(AMICAR_Respuesta_PJ_Simulation.cls_dealerSurcharges familia :jsonR.dealerSurcharges  ){
                String clave = familia.description + ' ' + familia.id + ' financingEntityInsurance';
                productosJsonFinancingEntityInsurance.add(clave);
                String idProductSF = mapProducts.get(clave);
                //Si no existe producto, agregarlo en lista
                if(String.isBlank(idProductSF)){
                    System.debug('No existe, crear '+clave);
                    Product2 prod2 = new Product2();
                    prod2.Name = familia.description;
                    prod2.Family = 'financingEntityInsurance';
                    prod2.IsActive = true;
                    prod2.Identificador__c = clave;
                    prod2.ProductCode = String.valueOf(familia.id);
                    prodToAdd.add(prod2);
                }
            }
            //revisar si no existen productos dealerSurcharges
            for(AMICAR_Respuesta_PJ_Simulation.cls_dealerSurcharges familia :jsonR.dealerSurcharges  ){
                String clave = familia.description + ' ' + familia.id + ' dealerSurcharges';
                productosJsonDealerSurcharges.add(clave);
                String idProductSF = mapProducts.get(clave);
                //Si no existe producto, agregarlo en lista
                if(String.isBlank(idProductSF)){
                    System.debug('No existe, crear '+clave);
                    Product2 prod2 = new Product2();
                    prod2.Name = familia.description;
                    prod2.Family = 'dealerSurcharges';
                    prod2.IsActive = true;
                    prod2.Identificador__c = clave;
                    prod2.ProductCode = String.valueOf(familia.id);
                    prodToAdd.add(prod2);
                }
            }
            //revisar si no existen productos financingEntitySurcharges
            for(AMICAR_Respuesta_PJ_Simulation.cls_dealerSurcharges familia :jsonR.dealerSurcharges ){
                String clave = familia.description + ' ' + familia.id + ' financingEntitySurcharges';
                productosJsonFinancingEntitySurcharges.add(clave);
                String idProductSF = mapProducts.get(clave);
                //Si no existe producto, agregarlo en lista
                if(String.isBlank(idProductSF)){
                    System.debug('No existe, crear '+clave);
                    Product2 prod2 = new Product2();
                    prod2.Name = familia.description;
                    prod2.Family = 'financingEntitySurcharges';
                    prod2.IsActive = true;
                    prod2.Identificador__c = clave;
                    prod2.ProductCode = String.valueOf(familia.id);
                    prodToAdd.add(prod2);
                }
            }
            if(prodToAdd.size() > 0){
                if(!Test.isRunningTest()){
                    System.debug(prodToAdd);
                    insert prodToAdd;
                    prod2List = [SELECT Identificador__c,Id,Family 
                                   FROM Product2 
                                  WHERE IsActive = true 
                                    AND Family IN : familias
                                ];
                    for(Product2 prod2 : prod2List){
                        mapProducts.put(prod2.Identificador__c, prod2.Id);
                    }
                }
            }
            Pricebook2 pb2 = [SELECT Id 
                                FROM Pricebook2 
                               WHERE Name =: 'Standard Price Book'
                                 AND IsActive = true
                             ];
            //Revisar si existen o no las listas de precio de los productos del JSON amicarAssistanceInsurance
            for(String clave : productosJsonAmicarAssistance){
                String idProd2 = mapProducts.get(clave);
                String idPricebookEntrySF = mapPricebooks.get(idProd2);
                if(String.isEmpty(idPricebookEntrySF)){
                    System.debug('Pricebook Id no encontrado = '+clave);
                    PricebookEntry price = new PricebookEntry();
                    price.UnitPrice = 1;
                    price.Product2Id = mapProducts.get(clave);
                    price.IsActive = true;
                    price.Pricebook2Id = pb2.Id;
                    priceToAdd.add(price);
                }
            }
            //Revisar si existen o no las listas de precio de los productos del JSON financingEntityInsurance
            for(String clave : productosJsonFinancingEntityInsurance){
                String idProd2 = mapProducts.get(clave);
                String idPricebookEntrySF = mapPricebooks.get(idProd2);
                if(String.isEmpty(idPricebookEntrySF)){
                    System.debug('Pricebook Id no encontrado = '+clave);
                    PricebookEntry price = new PricebookEntry();
                    price.UnitPrice = 1;
                    price.Product2Id = mapProducts.get(clave);
                    price.IsActive = true;
                    price.Pricebook2Id = pb2.Id;
                    priceToAdd.add(price);
                }
            }
            //Revisar si existen o no las listas de precio de los productos del JSON dealerSurcharges
            for(String clave : productosJsonDealerSurcharges){
                String idProd2 = mapProducts.get(clave);
                String idPricebookEntrySF = mapPricebooks.get(idProd2);
                if(String.isEmpty(idPricebookEntrySF)){
                    System.debug('Pricebook Id no encontrado = '+clave);
                    PricebookEntry price = new PricebookEntry();
                    price.UnitPrice = 1;
                    price.Product2Id = mapProducts.get(clave);
                    price.IsActive = true;
                    price.Pricebook2Id = pb2.Id;
                    priceToAdd.add(price);
                }
            }
            //Revisar si existen o no las listas de precio de los productos del JSON financingEntitySurcharges
            for(String clave : productosJsonFinancingEntitySurcharges){
                String idProd2 = mapProducts.get(clave);
                String idPricebookEntrySF = mapPricebooks.get(idProd2);
                if(String.isEmpty(idPricebookEntrySF)){
                    System.debug('Pricebook Id no encontrado = '+clave);
                    PricebookEntry price = new PricebookEntry();
                    price.UnitPrice = 1;
                    price.Product2Id = mapProducts.get(clave);
                    price.IsActive = true;
                    price.Pricebook2Id = pb2.Id;
                    priceToAdd.add(price);
                }
            }
            if(priceToAdd.size() > 0){
                if(!Test.isRunningTest()){
                    insert priceToAdd;
                }
            }
        }catch(Exception ex){
            System.debug('ERROR INSERT PRODUCTOS/PRICEBOOK');
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
        }   
    }
    
}