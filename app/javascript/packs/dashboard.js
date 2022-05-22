$(document).ready(function(){
    $('#sharedExpense').hide();
    $('#friendsExpense').hide();

    $('#sharedExpensesTab').on('click', function(){
      $('#myExpense').hide();
      $('#sharedExpense').show();
      $('#friendsExpense').hide();
    });

    $('#allExpensesTab').on('click', function(){
      $('#myExpense').show();
      $('#sharedExpense').hide();
      $('#friendsExpense').hide();
    });

    $('#friendsExpensesTab').on('click', function(){
      $('#myExpense').hide();
      $('#sharedExpense').hide();
      $('#friendsExpense').show();
    });


    $('.sharedClickableRow').on('click', function(){
      var user_id = $(this).data("user_id")
      $.ajax({
        type:"GET",
        url:"expenses_with_user",
        dataType:"json",
        data: {user_id: user_id},
        success:function(result){
          $('#sharedExpenseContainer').empty();
          $('#sharedExpenseContainer').append(result.expenses_table)
          // createSharedExpensesTable(result);
        },
        error:function(result){
          //TODO Call Error Modal
        }
      });
    });

    $('.friendsClickableRow').on('click', function(){
      var user_id = $(this).data("user_id")
      $.ajax({
        type:"GET",
        url:"friends_expenses",
        dataType:"json",
        data: {user_id: user_id},
        success:function(result){
          $('#friendsExpensesContainer').empty();
          $('#friendsExpensesContainer').append(result.expenses_table)
          // createSharedExpensesTable(result);
        },
        error:function(result){
          //TODO Call Error Modal
        }
      });
    });
});


function createSharedExpensesTable(data){
  $('#sharedExpenseContainer').html(data)
}
