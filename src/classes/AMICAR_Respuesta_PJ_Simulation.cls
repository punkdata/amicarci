public class AMICAR_Respuesta_PJ_Simulation{
	public Integer simulationId;	//10001738
	public cls_finalLoanValues finalLoanValues;
	public cls_equivalentAnnualCharge equivalentAnnualCharge;
	public cls_amortizationSchedule[] amortizationSchedule;
	public cls_surchargesAndInsurances surchargesAndInsurances;
	public class cls_finalLoanValues {
		public String loanType;	//CONVENTIONAL
		public String rateType;	//CONVENTIONAL_NORMAL
		public Integer term;	//48
		public Integer balance;	//9000000
		public Integer downPaymentPercentage;	//25
		public Double UFValue;	//29149.08
		public Integer totalSurchargesToMAF;	//400000
		public Integer totalSurchargesToQuote;	//0
		public Integer totalSurchargesToQuoteMafPercentage;	//0
		public Integer totalSurchargesToQuoteMafValue;	//0
		public Double factorTotal;	//0.931
		public Double promissoryFactor;	//0.008
		public Integer promissoryValue;	//80773
		public Integer totalToFinance;	//10096670
		public Double totalToFinanceUF;	//346.38
		public Integer finalCapital;	//10096670
		public Integer daysDelayedFirstDue;	//30
		public Integer delayedInterest;	//0
		public Integer monthlyPayment;	//304883
		public Double customerRate;	//1.63
		public Double dealerRate;	//1.33
		public Integer dealerCommission;	//669061
		public Integer amicarCommission;	//1480958
	}
	public class cls_equivalentAnnualCharge {
		public Double annualCAE;	//26.28
		public Double monthlyCAE;	//2.19
		public Integer totalLoanCost;	//14634384
	}
	public class cls_amortizationSchedule {
		public Integer paymentNumber;	//1
		public String expirationDate;	//2020-10-17
		public Integer daysBetweenExpirationsDates;	//30
		public String quotaType;	//REGULAR
		public Integer payment;	//304883
		public Integer beginningBalance;	//10096670
		public Integer principal;	//140308
		public Integer interest;	//164576
		public Integer endingBalance;	//9956362
		public Integer cumulativeInterest;	//164576
		public Integer totalSurchargesToQuote;	//0
		public Integer finalPayment;	//304883
	}
	public class cls_surchargesAndInsurances {
		public cls_amicarAssistance[] amicarAssistance;
		public cls_dealerSurcharges[] dealerSurcharges;
		public cls_dealerInsurance[] dealerInsurance;
		public cls_financingEntitySurcharges[] financingEntitySurcharges;
		public cls_financingEntityInsurance[] financingEntityInsurance;
	}
	public class cls_amicarAssistance {
	}
	public class cls_dealerSurcharges {
		public Integer id;	//1
		public String description;	//IMPUESTO VERDE
		public Integer value;	//0
		public boolean isEditable;
		public String currencyType;	//CLP
		public Integer factorCalculated;	//0
		public boolean selected;
		public boolean isRequired;
		public Integer legacyId;	//0
	}
	public class cls_dealerInsurance {
	}
	public class cls_financingEntitySurcharges {
		public Integer id;	//883
		public String description;	//G. OPERACIONALES
		public Integer value;	//400000
		public boolean isEditable;
		public String currencyType;	//CLP
		public Integer factorCalculated;	//400000
		public boolean selected;
		public boolean isRequired;
		public Integer legacyId;	//0
	}
	public class cls_financingEntityInsurance {
		public Integer id;	//407
		public String description;	//DESGRAVAMEN
		public Integer value;	//61
		public String currencyType;	//CLP
		public Integer factorCalculated;	//615897
		public boolean selected;
		public boolean isRequired;
		public String insuranceType;	//RELIEF
		public Integer legacyId;	//0
	}
	public static AMICAR_Respuesta_PJ_Simulation parse(String json){
		return (AMICAR_Respuesta_PJ_Simulation) System.JSON.deserialize(json, AMICAR_Respuesta_PJ_Simulation.class);
	}
}
	/*static testMethod void testParse() {
		String json=		'{'+
		'    "simulationId": 10001738,'+
		'    "finalLoanValues": {'+
		'        "loanType": "CONVENTIONAL",'+
		'        "rateType": "CONVENTIONAL_NORMAL",'+
		'        "term": 48,'+
		'        "balance": 9000000,'+
		'        "downPaymentPercentage": 25,'+
		'        "UFValue": 29149.08,'+
		'        "totalSurchargesToMAF": 400000,'+
		'        "totalSurchargesToQuote": 0,'+
		'        "totalSurchargesToQuoteMafPercentage": 0,'+
		'        "totalSurchargesToQuoteMafValue": 0,'+
		'        "factorTotal": 0.931,'+
		'        "promissoryFactor": 0.008,'+
		'        "promissoryValue": 80773,'+
		'        "totalToFinance": 10096670,'+
		'        "totalToFinanceUF": 346.38,'+
		'        "finalCapital": 10096670,'+
		'        "daysDelayedFirstDue": 30,'+
		'        "delayedInterest": 0,'+
		'        "monthlyPayment": 304883,'+
		'        "customerRate": 1.63,'+
		'        "dealerRate": 1.33,'+
		'        "dealerCommission": 669061,'+
		'        "amicarCommission": 1480958'+
		'    },'+
		'    "equivalentAnnualCharge": {'+
		'        "annualCAE": 26.28,'+
		'        "monthlyCAE": 2.19,'+
		'        "totalLoanCost": 14634384'+
		'    },'+
		'    "amortizationSchedule": ['+
		'        {'+
		'            "paymentNumber": 1,'+
		'            "expirationDate": "2020-10-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 10096670,'+
		'            "principal": 140308,'+
		'            "interest": 164576,'+
		'            "endingBalance": 9956362,'+
		'            "cumulativeInterest": 164576,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 2,'+
		'            "expirationDate": "2020-11-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 9956362,'+
		'            "principal": 142595,'+
		'            "interest": 162289,'+
		'            "endingBalance": 9813768,'+
		'            "cumulativeInterest": 326864,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 3,'+
		'            "expirationDate": "2020-12-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 9813768,'+
		'            "principal": 144919,'+
		'            "interest": 159964,'+
		'            "endingBalance": 9668849,'+
		'            "cumulativeInterest": 486829,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 4,'+
		'            "expirationDate": "2021-01-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 9668849,'+
		'            "principal": 147281,'+
		'            "interest": 157602,'+
		'            "endingBalance": 9521568,'+
		'            "cumulativeInterest": 644431,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 5,'+
		'            "expirationDate": "2021-02-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 9521568,'+
		'            "principal": 149682,'+
		'            "interest": 155202,'+
		'            "endingBalance": 9371886,'+
		'            "cumulativeInterest": 799633,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 6,'+
		'            "expirationDate": "2021-03-17",'+
		'            "daysBetweenExpirationsDates": 28,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 9371886,'+
		'            "principal": 152122,'+
		'            "interest": 152762,'+
		'            "endingBalance": 9219764,'+
		'            "cumulativeInterest": 952394,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 7,'+
		'            "expirationDate": "2021-04-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 9219764,'+
		'            "principal": 154601,'+
		'            "interest": 150282,'+
		'            "endingBalance": 9065163,'+
		'            "cumulativeInterest": 1102677,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 8,'+
		'            "expirationDate": "2021-05-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 9065163,'+
		'            "principal": 157121,'+
		'            "interest": 147762,'+
		'            "endingBalance": 8908042,'+
		'            "cumulativeInterest": 1250439,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 9,'+
		'            "expirationDate": "2021-06-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 8908042,'+
		'            "principal": 159682,'+
		'            "interest": 145201,'+
		'            "endingBalance": 8748360,'+
		'            "cumulativeInterest": 1395640,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 10,'+
		'            "expirationDate": "2021-07-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 8748360,'+
		'            "principal": 162285,'+
		'            "interest": 142598,'+
		'            "endingBalance": 8586075,'+
		'            "cumulativeInterest": 1538238,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 11,'+
		'            "expirationDate": "2021-08-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 8586075,'+
		'            "principal": 164930,'+
		'            "interest": 139953,'+
		'            "endingBalance": 8421144,'+
		'            "cumulativeInterest": 1678191,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 12,'+
		'            "expirationDate": "2021-09-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 8421144,'+
		'            "principal": 167619,'+
		'            "interest": 137265,'+
		'            "endingBalance": 8253526,'+
		'            "cumulativeInterest": 1815456,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 13,'+
		'            "expirationDate": "2021-10-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 8253526,'+
		'            "principal": 170351,'+
		'            "interest": 134532,'+
		'            "endingBalance": 8083175,'+
		'            "cumulativeInterest": 1949988,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 14,'+
		'            "expirationDate": "2021-11-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 8083175,'+
		'            "principal": 173128,'+
		'            "interest": 131756,'+
		'            "endingBalance": 7910047,'+
		'            "cumulativeInterest": 2081744,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 15,'+
		'            "expirationDate": "2021-12-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 7910047,'+
		'            "principal": 175950,'+
		'            "interest": 128934,'+
		'            "endingBalance": 7734097,'+
		'            "cumulativeInterest": 2210678,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 16,'+
		'            "expirationDate": "2022-01-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 7734097,'+
		'            "principal": 178818,'+
		'            "interest": 126066,'+
		'            "endingBalance": 7555280,'+
		'            "cumulativeInterest": 2336743,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 17,'+
		'            "expirationDate": "2022-02-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 7555280,'+
		'            "principal": 181732,'+
		'            "interest": 123151,'+
		'            "endingBalance": 7373548,'+
		'            "cumulativeInterest": 2459895,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 18,'+
		'            "expirationDate": "2022-03-17",'+
		'            "daysBetweenExpirationsDates": 28,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 7373548,'+
		'            "principal": 184695,'+
		'            "interest": 120189,'+
		'            "endingBalance": 7188853,'+
		'            "cumulativeInterest": 2580083,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 19,'+
		'            "expirationDate": "2022-04-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 7188853,'+
		'            "principal": 187705,'+
		'            "interest": 117178,'+
		'            "endingBalance": 7001148,'+
		'            "cumulativeInterest": 2697262,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 20,'+
		'            "expirationDate": "2022-05-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 7001148,'+
		'            "principal": 190765,'+
		'            "interest": 114119,'+
		'            "endingBalance": 6810383,'+
		'            "cumulativeInterest": 2811380,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 21,'+
		'            "expirationDate": "2022-06-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 6810383,'+
		'            "principal": 193874,'+
		'            "interest": 111009,'+
		'            "endingBalance": 6616509,'+
		'            "cumulativeInterest": 2922390,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 22,'+
		'            "expirationDate": "2022-07-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 6616509,'+
		'            "principal": 197034,'+
		'            "interest": 107849,'+
		'            "endingBalance": 6419475,'+
		'            "cumulativeInterest": 3030239,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 23,'+
		'            "expirationDate": "2022-08-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 6419475,'+
		'            "principal": 200246,'+
		'            "interest": 104637,'+
		'            "endingBalance": 6219229,'+
		'            "cumulativeInterest": 3134876,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 24,'+
		'            "expirationDate": "2022-09-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 6219229,'+
		'            "principal": 203510,'+
		'            "interest": 101373,'+
		'            "endingBalance": 6015719,'+
		'            "cumulativeInterest": 3236250,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 25,'+
		'            "expirationDate": "2022-10-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 6015719,'+
		'            "principal": 206827,'+
		'            "interest": 98056,'+
		'            "endingBalance": 5808892,'+
		'            "cumulativeInterest": 3334306,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 26,'+
		'            "expirationDate": "2022-11-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 5808892,'+
		'            "principal": 210198,'+
		'            "interest": 94685,'+
		'            "endingBalance": 5598694,'+
		'            "cumulativeInterest": 3428991,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 27,'+
		'            "expirationDate": "2022-12-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 5598694,'+
		'            "principal": 213625,'+
		'            "interest": 91259,'+
		'            "endingBalance": 5385069,'+
		'            "cumulativeInterest": 3520249,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 28,'+
		'            "expirationDate": "2023-01-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 5385069,'+
		'            "principal": 217107,'+
		'            "interest": 87777,'+
		'            "endingBalance": 5167962,'+
		'            "cumulativeInterest": 3608026,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 29,'+
		'            "expirationDate": "2023-02-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 5167962,'+
		'            "principal": 220646,'+
		'            "interest": 84238,'+
		'            "endingBalance": 4947317,'+
		'            "cumulativeInterest": 3692264,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 30,'+
		'            "expirationDate": "2023-03-17",'+
		'            "daysBetweenExpirationsDates": 28,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 4947317,'+
		'            "principal": 224242,'+
		'            "interest": 80641,'+
		'            "endingBalance": 4723075,'+
		'            "cumulativeInterest": 3772905,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 31,'+
		'            "expirationDate": "2023-04-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 4723075,'+
		'            "principal": 227897,'+
		'            "interest": 76986,'+
		'            "endingBalance": 4495178,'+
		'            "cumulativeInterest": 3849891,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 32,'+
		'            "expirationDate": "2023-05-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 4495178,'+
		'            "principal": 231612,'+
		'            "interest": 73271,'+
		'            "endingBalance": 4263566,'+
		'            "cumulativeInterest": 3923163,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 33,'+
		'            "expirationDate": "2023-06-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 4263566,'+
		'            "principal": 235387,'+
		'            "interest": 69496,'+
		'            "endingBalance": 4028178,'+
		'            "cumulativeInterest": 3992659,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 34,'+
		'            "expirationDate": "2023-07-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 4028178,'+
		'            "principal": 239224,'+
		'            "interest": 65659,'+
		'            "endingBalance": 3788954,'+
		'            "cumulativeInterest": 4058318,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 35,'+
		'            "expirationDate": "2023-08-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 3788954,'+
		'            "principal": 243123,'+
		'            "interest": 61760,'+
		'            "endingBalance": 3545831,'+
		'            "cumulativeInterest": 4120078,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 36,'+
		'            "expirationDate": "2023-09-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 3545831,'+
		'            "principal": 247086,'+
		'            "interest": 57797,'+
		'            "endingBalance": 3298745,'+
		'            "cumulativeInterest": 4177875,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 37,'+
		'            "expirationDate": "2023-10-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 3298745,'+
		'            "principal": 251114,'+
		'            "interest": 53770,'+
		'            "endingBalance": 3047631,'+
		'            "cumulativeInterest": 4231645,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 38,'+
		'            "expirationDate": "2023-11-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 3047631,'+
		'            "principal": 255207,'+
		'            "interest": 49676,'+
		'            "endingBalance": 2792424,'+
		'            "cumulativeInterest": 4281321,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 39,'+
		'            "expirationDate": "2023-12-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 2792424,'+
		'            "principal": 259367,'+
		'            "interest": 45517,'+
		'            "endingBalance": 2533057,'+
		'            "cumulativeInterest": 4326838,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 40,'+
		'            "expirationDate": "2024-01-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 2533057,'+
		'            "principal": 263595,'+
		'            "interest": 41289,'+
		'            "endingBalance": 2269462,'+
		'            "cumulativeInterest": 4368126,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 41,'+
		'            "expirationDate": "2024-02-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 2269462,'+
		'            "principal": 267891,'+
		'            "interest": 36992,'+
		'            "endingBalance": 2001571,'+
		'            "cumulativeInterest": 4405119,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 42,'+
		'            "expirationDate": "2024-03-17",'+
		'            "daysBetweenExpirationsDates": 29,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 2001571,'+
		'            "principal": 272258,'+
		'            "interest": 32626,'+
		'            "endingBalance": 1729314,'+
		'            "cumulativeInterest": 4437744,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 43,'+
		'            "expirationDate": "2024-04-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 1729314,'+
		'            "principal": 276696,'+
		'            "interest": 28188,'+
		'            "endingBalance": 1452618,'+
		'            "cumulativeInterest": 4465932,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 44,'+
		'            "expirationDate": "2024-05-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 1452618,'+
		'            "principal": 281206,'+
		'            "interest": 23678,'+
		'            "endingBalance": 1171412,'+
		'            "cumulativeInterest": 4489610,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 45,'+
		'            "expirationDate": "2024-06-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 1171412,'+
		'            "principal": 285789,'+
		'            "interest": 19094,'+
		'            "endingBalance": 885623,'+
		'            "cumulativeInterest": 4508704,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 46,'+
		'            "expirationDate": "2024-07-17",'+
		'            "daysBetweenExpirationsDates": 30,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 885623,'+
		'            "principal": 290448,'+
		'            "interest": 14436,'+
		'            "endingBalance": 595175,'+
		'            "cumulativeInterest": 4523139,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 47,'+
		'            "expirationDate": "2024-08-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 595175,'+
		'            "principal": 295182,'+
		'            "interest": 9701,'+
		'            "endingBalance": 299993,'+
		'            "cumulativeInterest": 4532841,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        },'+
		'        {'+
		'            "paymentNumber": 48,'+
		'            "expirationDate": "2024-09-17",'+
		'            "daysBetweenExpirationsDates": 31,'+
		'            "quotaType": "REGULAR",'+
		'            "payment": 304883,'+
		'            "beginningBalance": 299993,'+
		'            "principal": 299993,'+
		'            "interest": 4890,'+
		'            "endingBalance": 0,'+
		'            "cumulativeInterest": 4537731,'+
		'            "totalSurchargesToQuote": 0,'+
		'            "finalPayment": 304883'+
		'        }'+
		'    ],'+
		'    "surchargesAndInsurances": {'+
		'        "amicarAssistance": [],'+
		'        "dealerSurcharges": ['+
		'            {'+
		'                "id": 1,'+
		'                "description": "IMPUESTO VERDE",'+
		'                "value": 0,'+
		'                "isEditable": true,'+
		'                "currencyType": "CLP",'+
		'                "factorCalculated": 0,'+
		'                "selected": false,'+
		'                "isRequired": false,'+
		'                "legacyId": 0'+
		'            },'+
		'            {'+
		'                "id": 3,'+
		'                "description": "PATENTE",'+
		'                "value": 0,'+
		'                "isEditable": true,'+
		'                "currencyType": "CLP",'+
		'                "factorCalculated": 0,'+
		'                "selected": false,'+
		'                "isRequired": false,'+
		'                "legacyId": 0'+
		'            },'+
		'            {'+
		'                "id": 5,'+
		'                "description": "INSCRIPCION",'+
		'                "value": 0,'+
		'                "isEditable": false,'+
		'                "currencyType": "CLP",'+
		'                "factorCalculated": 0,'+
		'                "selected": true,'+
		'                "isRequired": true,'+
		'                "legacyId": 0'+
		'            },'+
		'            {'+
		'                "id": 9,'+
		'                "description": "MANTENCION PREPAGADA",'+
		'                "value": 0,'+
		'                "isEditable": true,'+
		'                "currencyType": "CLP",'+
		'                "factorCalculated": 0,'+
		'                "selected": false,'+
		'                "isRequired": false,'+
		'                "legacyId": 0'+
		'            }'+
		'        ],'+
		'        "dealerInsurance": [],'+
		'        "financingEntitySurcharges": ['+
		'            {'+
		'                "id": 883,'+
		'                "description": "G. OPERACIONALES",'+
		'                "value": 400000,'+
		'                "isEditable": false,'+
		'                "currencyType": "CLP",'+
		'                "factorCalculated": 400000,'+
		'                "selected": true,'+
		'                "isRequired": true,'+
		'                "legacyId": 0'+
		'            }'+
		'        ],'+
		'        "financingEntityInsurance": ['+
		'            {'+
		'                "id": 407,'+
		'                "description": "DESGRAVAMEN",'+
		'                "value": 61,'+
		'                "currencyType": "CLP",'+
		'                "factorCalculated": 615897,'+
		'                "selected": true,'+
		'                "isRequired": true,'+
		'                "insuranceType": "RELIEF",'+
		'                "legacyId": 0'+
		'            }'+
		'        ]'+
		'    }'+
		'}';
		AMICAR_Respuesta_PJ_Simulation obj = parse(json);
		System.assert(obj != null);
	}*/