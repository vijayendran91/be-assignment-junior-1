module BillServices

  def add_bill_with_params_service(params)
    bill = Bill.new(params)
    bill.save
    bill
  end

  def get_bill_from_id_service(bill_id)
    Bill.find_by(:id => bill_id)
  end
end
