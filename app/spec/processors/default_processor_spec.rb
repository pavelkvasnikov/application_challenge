RSpec.describe Processor::DefaultProcessor do

  VISITS =
      [
          {:id => 1, :evid => "966634dc-0bf6-1ff7-f4b6-08000c95c670", :vendor_site_id => "209", :vendor_visit_id => "134853732", :visit_ip => "24.6.5.33", :vendor_visitor_id => "e280af5191b64f18"},
          {:id => 2, :evid => "", :vendor_site_id => "209", :vendor_visit_id => "134853338", :visit_ip => "24.6.5.33", :vendor_visitor_id => "e280af5191b64f18"},
          {:id => 3, :evid => "3385a27a-cc20-8d98-940a-37dad5a93133", :vendor_site_id => "209", :vendor_visit_id => "134849628", :visit_ip => "24.6.5.33", :vendor_visitor_id => "e280af5191b64f18"},
          {:id => 4, :evid => "", :vendor_site_id => "209", :vendor_visit_id => "134843051", :visit_ip => "24.6.5.33", :vendor_visitor_id => "e280af5191b64f18"}
      ].freeze

  PAGE_VIEWS =
      [
          {:id => 1, :visit_id => 1, :title => "Vehicle Loan Information", :position => "0", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "50", :timestamp => 0.1537623918e10},
          {:id => 2, :visit_id => 1, :title => "Vehicle Loan Information", :position => "1", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "1", :timestamp => 0.1537623579e10},
          {:id => 3, :visit_id => 1, :title => "Vehicle Loan Information", :position => "2", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "337", :timestamp => 0.153762358e10},
          {:id => 4, :visit_id => 1, :title => "Vehicle Loan Information", :position => "3", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "1", :timestamp => 0.1537623917e10},
          {:id => 5, :visit_id => 1, :title => "Vehicle Loan Information", :position => "4", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "50", :timestamp => 0.1537623918e10},
          {:id => 6, :visit_id => 1, :title => "Vehicle Loan Information", :position => "5", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&time=1-45-pm&l=1", :time_spent => "1", :timestamp => 0.1537623968e10},
          {:id => 7, :visit_id => 1, :title => "Vehicle Loan Information", :position => "6", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&time=1-45-pm&l=1", :time_spent => "463", :timestamp => 0.1537623969e10},
          {:id => 8, :visit_id => 1, :title => "Vehicle Loan Information", :position => "7", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "1", :timestamp => 0.1537624432e10},
          {:id => 9, :visit_id => 1, :title => "Vehicle Loan Information", :position => "8", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "1161", :timestamp => 0.1537624433e10},
          {:id => 10, :visit_id => 1, :title => "Vehicle Loan Information", :position => "9", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&evid=evid&l=1", :time_spent => "1", :timestamp => 0.1537625594e10},
          {:id => 11, :visit_id => 1, :title => "Vehicle Loan Information", :position => "10", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&evid=evid&l=1", :time_spent => nil, :timestamp => 0.1537625595e10},
          {:id => 12, :visit_id => 2, :title => "Alert Popup", :position => "0", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/alert-popup?lenderref=Meriwest_test&evid=12-56-pm&l=1", :time_spent => "15", :timestamp => 0.1537623145e10},
          {:id => 13, :visit_id => 2, :title => "Applicant Information", :position => "1", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/applicant-information?lenderref=Meriwest_test&evid=12-56-pm&l=1", :time_spent => "1", :timestamp => 0.153762316e10},
          {:id => 14, :visit_id => 2, :title => "Applicant Information", :position => "2", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/applicant-information?lenderref=Meriwest_test&evid=12-56-pm&l=1", :time_spent => "3", :timestamp => 0.1537623161e10},
          {:id => 15, :visit_id => 2, :title => "Vehicle Loan Information", :position => "3", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&evid=12-56-pm&l=1", :time_spent => "1", :timestamp => 0.1537623164e10},
          {:id => 16, :visit_id => 2, :title => "Vehicle Loan Information", :position => "4", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&evid=12-56-pm&l=1", :time_spent => nil, :timestamp => 0.1537623165e10},
          {:id => 17, :visit_id => 3, :title => "Vehicle Loan Information", :position => "0", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "368", :timestamp => 0.153761948e10},
          {:id => 18, :visit_id => 3, :title => "Applicant Information", :position => "1", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/applicant-information?lenderref=Meriwest_test&l=1", :time_spent => "1229", :timestamp => 0.1537619848e10},
          {:id => 19, :visit_id => 3, :title => "Vehicle Loan Information", :position => "2", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&evid=12-56-pm&l=1", :time_spent => "0", :timestamp => 0.1537621077e10},
          {:id => 20, :visit_id => 3, :title => "Vehicle Loan Information", :position => "3", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&evid=12-56-pm&l=1", :time_spent => "123", :timestamp => 0.1537621077e10},
          {:id => 21, :visit_id => 3, :title => "Applicant Information", :position => "4", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/applicant-information?lenderref=Meriwest_test&evid=12-56-pm&l=1", :time_spent => nil, :timestamp => 0.15376212e10},
          {:id => 22, :visit_id => 4, :title => "Personal Loan Information", :position => "0", :url => "https://apptest.loanspq.com/pl/PersonalLoan.aspx/personal-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "1", :timestamp => 0.1537613572e10},
          {:id => 23, :visit_id => 4, :title => "Vehicle Loan Information", :position => "1", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&rec=1&uid=evid_808asdfaasdv7a6s5dasdfva7s8d6f&l=1", :time_spent => "1075", :timestamp => 0.1537614509e10},
          {:id => 24, :visit_id => 4, :title => "Personal Loan Information", :position => "2", :url => "https://apptest.loanspq.com/pl/PersonalLoan.aspx/personal-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "734", :timestamp => 0.1537613573e10},
          {:id => 25, :visit_id => 4, :title => "Vehicle Loan Information", :position => "3", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "1", :timestamp => 0.1537614307e10},
          {:id => 26, :visit_id => 4, :title => "Vehicle Loan Information", :position => "4", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1", :time_spent => "200", :timestamp => 0.1537614308e10},
          {:id => 27, :visit_id => 4, :title => "Vehicle Loan Information", :position => "5", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&rec=1&uid=evid_808asdfaasdv7a6s5dasdfva7s8d6f&l=1", :time_spent => "1", :timestamp => 0.1537614508e10},
          {:id => 28, :visit_id => 4, :title => "Vehicle Loan Information", :position => "6", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&cb-vid=64c1f015-00ea-f186-6bb8-c545347e3075&l=1", :time_spent => "0", :timestamp => 0.1537615584e10},
          {:id => 29, :visit_id => 4, :title => "Vehicle Loan Information", :position => "7", :url => "https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&cb-vid=64c1f015-00ea-f186-6bb8-c545347e3075&l=1", :time_spent => nil, :timestamp => 0.1537615584e10}
      ]

  describe '.call' do
    it 'calls method chain' do
      subject.call
      conn = Sequel.connect('mysql2://root:pass@mysql:3306')
      conn.execute('use visitor')
      expect(conn[:visits].all).to match(VISITS)
      expect(conn[:page_views].all).to match(PAGE_VIEWS)
    end
  end
end
