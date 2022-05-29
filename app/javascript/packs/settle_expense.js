$('document').ready(function(){
  $('.settleExpenseClickable').on('click', function(){
    $('#settleExpenseModal').show();
    var expense_id = $(this).data('expense-id');
    $.ajax({
      type:"GET",
      url:"settle_expense",
      dataType:"json",
      data: {expense_id: expense_id},
      success:function(result){
        buildSettleExpenseModal(result);
      },
      error:function(result){
        //TODO Call Error Modal
      }
    });
  });

  function buildSettleExpenseModal(result){
    const event = new Date(result['expense']['created_at']);
    const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
    $('.settleAmount').empty();
    $('.settleAmount').append(result['expense']['amount']);
    $('.settleBorrowedFrom').empty();
    $('.settleBorrowedFrom').append(result['expense']['borrowed_from_name']);
    $('.settleBorrower').empty();
    $('.settleBorrower').append(result['expense']['borrower_name']);
    $('.settleDateOfExpense').empty();
    $('.settleDateOfExpense').append(event.toLocaleDateString('en-EN', options))
    $('.settleExpenseId').empty();
    $("<input>").attr({
                name: "expense_id",
                id: "hiddenId",
                type: "hidden",
                value: result['expense']['id']
            }).appendTo(".settleExpenseId");
  }


});
