module BillApplication
  require_relative "../services/bill_services"

  include BillServices

  def add_bill(params)
    bill_attrs = {
      :paid_by => params[:paid_by],
      :amount => params[:amount],
      :no_parts => params[:no_parts],
      :desc => params[:desc]
    }
    @bill= add_bill_with_params_service(bill_attrs)
    unless @bill.errors.empty?
      raise BillStorageError.new(@bill.errors.full_messages.to_sentence)
    end
    @bill
  end

end
