public class AMICAR_OpportunityJSONPJuridica {

	public String stage {get;set;} 
	public Integer simulationId {get;set;} 
	public String sellerIdentificationValue {get;set;} 
	public String amicarExecutiveIdentificationValue {get;set;} 
	public Customer customer {get;set;} 
	public CustomerRequestData customerRequestData {get;set;} 
	public List<CustomerSuppliers> customerSuppliers {get;set;} 
	public List<LegalRepresentative> legalRepresentative {get;set;} 
	public List<MajorityPartners> majorityPartners {get;set;} 
	public CustomerActivity customerActivity {get;set;} 
	public Income income {get;set;} 
	public OtherIncome otherIncome {get;set;} 
	public Expenses expenses {get;set;} 
	public List<TaxReturn> taxReturn {get;set;} 
	public SpouseData spouseData {get;set;} 
	public BuyForAnother buyForAnother {get;set;} 
	public List<Guarantor> guarantor {get;set;} 
	public List<BankInformation> bankInformation {get;set;} 
	public List<Heritage> heritage {get;set;} 
	public List<PersonalReferences> personalReferences {get;set;} 

	public class Customer {
		public Integer identificationTypeId {get;set;} 
		public String identificationValue {get;set;} 
		public String documentSerialNumber {get;set;} 
		public String name {get;set;} 
		public String lastName {get;set;} 
		public String motherLastName {get;set;} 
		public String email {get;set;} 
		public String phone {get;set;} 
		public String address {get;set;} 
		public String geographicDataId {get;set;} 
		public String dob {get;set;} 
		public String nationality {get;set;} 
		public String gender {get;set;} 
		public String companyName {get;set;} 
		public String businessSectorId {get;set;} 
		public String businessSectorDescription {get;set;} 
		public Integer numberOfWorkers {get;set;} 
		public String workPhone {get;set;} 
		public String contactName {get;set;} 
		public String contactWorkPosition {get;set;} 
		public String contactPhone {get;set;} 
		public String contactWorkPhone {get;set;} 
		public String contactEmail {get;set;} 
	}

	public class CustomerRequestData {
		public String maritalStatus {get;set;} 
		public String maritalRegime {get;set;} 
		public String academicLevel {get;set;} 
		public String livingHousehold {get;set;} 
		public String profession {get;set;} 
		public String generalComments {get;set;} 
	}
	
	public class CustomerSuppliers {
		public String name {get;set;} 
		public String phone {get;set;} 
		public String relationship {get;set;} 
	}

	public class LegalRepresentative {
		public String identificationValue {get;set;} 
		public String name {get;set;} 
		public Integer activityTypeId {get;set;} 
		public String phone {get;set;} 
		public String address {get;set;} 
		public String geographicDataId {get;set;} 
		public Boolean isGuarantor {get;set;} 
		public String maritalStatus {get;set;} 
		public String email {get;set;} 
	}

	public class MajorityPartners {
		public String identificationValue {get;set;} 
		public String name {get;set;} 
		public String address {get;set;} 
		public String phone {get;set;} 
		public String profession {get;set;} 
		public Integer houseAppraisal {get;set;} 
		public Integer vehicleAppraisal {get;set;} 
		public Integer participationPercentage {get;set;} 
	}

	public class CustomerActivity {
		public String workType {get;set;} 
		public String activityTypeId {get;set;} 
		public String workPosition {get;set;} 
		public String workEntryDate {get;set;} 
		public String employerName {get;set;} 
		public Integer employerIdentificationTypeId {get;set;} 
		public String employerIdentificationValue {get;set;} 
		public String businessSectorId {get;set;} 
		public String workAddress {get;set;} 
		public String workGeographicDataId {get;set;} 
		public String workPhone {get;set;} 
		public String employmentContractType {get;set;} 
		public String salaryType {get;set;} 
		public Integer salaryPayday {get;set;} 
	}

	public class Income {
		public Integer salary {get;set;} 
		public Integer honorarium {get;set;} 
		public Integer retirementSalary {get;set;} 
		public Integer pensionSalary {get;set;} 
		public Integer rentalIncome {get;set;} 
		public Integer otherIncome {get;set;} 
		public String descriptionForOtherIncome {get;set;} 
	}

	public class OtherIncome {
		public Integer year {get;set;} 
		public Integer foliointeger {get;set;} 
		public Integer code18 {get;set;} 
		public Integer code25 {get;set;} 
		public Integer code36 {get;set;} 
		public Integer code158 {get;set;} 
		public Integer code170 {get;set;} 
		public Integer code305 {get;set;} 
		public Integer code461 {get;set;} 
		public Integer code545 {get;set;} 
		public Integer code611 {get;set;} 
		public Integer code628 {get;set;} 
		public Integer code636 {get;set;} 
	}
	
	public class Expenses {
		public Integer mortgageCost {get;set;} 
		public Integer otherFixedExpenses {get;set;} 
	}
	
	public class TaxReturn {
		public String dateTax {get;set;} 
		public Integer purchaseTax {get;set;} 
		public Integer salesTax {get;set;} 
	}
	
	public class SpouseData {
		public Integer identificationType {get;set;} 
		public String identificationValue {get;set;} 
		public String name {get;set;} 
		public String lastName {get;set;} 
		public String motherLastName {get;set;} 
		public String address {get;set;} 
		public String spouseGeographicDataId {get;set;} 
		public String workType {get;set;} 
		public String activityTypeId {get;set;} 
		public String employerName {get;set;} 
		public String workPhone {get;set;} 
		public Boolean combinedIncome {get;set;} 
		public Integer salary {get;set;} 
	}

	public class BuyForAnother {
		public Integer identificationTypeId {get;set;} 
		public String identificationValue {get;set;} 
		public String name {get;set;} 
		public String lastName {get;set;} 
		public String motherLastName {get;set;} 
		public String address {get;set;} 
		public String geographicDataId {get;set;} 
		public String dob {get;set;} 
		public String nationalityId {get;set;} 
		public String maritalStatus {get;set;} 
		public String maritalRegime {get;set;} 
	}

	public class Guarantor {
		public Integer identificationTypeId {get;set;} 
		public String identificationValue {get;set;} 
		public String name {get;set;} 
		public String lastName {get;set;} 
		public String motherLastName {get;set;} 
		public String address {get;set;} 
		public String geographicDataId {get;set;} 
		public String dob {get;set;} 
		public String nationalityId {get;set;} 
		public String maritalStatus {get;set;} 
		public String maritalRegime {get;set;} 
		public String workType {get;set;} 
		public String activityTypeId {get;set;} 
		public Integer salary {get;set;} 
	}

	public class BankInformation {
		public String codeId {get;set;} 
		public Boolean automaticPayment {get;set;} 
		public String accountNumber {get;set;} 
	}

	public class Heritage {
		public String type_Z {get;set;} // in json: type
		public String description {get;set;} 
		public Integer saleValue {get;set;} 
		public String financing {get;set;} 
		public Boolean stillPaying {get;set;} 
	}

	public class PersonalReferences {
		public String name {get;set;} 
		public String type_Z {get;set;} // in json: type
		public String address {get;set;} 
		public String phone {get;set;} 
	}
	
	public static AMICAR_OpportunityJSONPJuridica parse(String json) {
		return (AMICAR_OpportunityJSONPJuridica) System.JSON.deserialize(json, AMICAR_OpportunityJSONPJuridica.class);
	}
	
	

}