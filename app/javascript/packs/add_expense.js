$('document').ready(function(){
  var add_expense_arr =[];

  $('.participants_checkbox').on('change', function(){
    add_expense_arr = [];
    $('#unequalSplit').empty();
    $('input.participants_checkbox:checkbox:checked').each(function () {
      // <input type="text" name="bill_amount" id="bill_amount" value=" " class="form-control add_expense_form_inputs">
      var user_name = $(this).data('user-name');
      var user_id = $(this).data('user-id');
      var temp = [user_name, user_id];
      add_expense_arr.push(temp);
      createUnequalSplit(add_expense_arr);
    });
  });

  function createUnequalSplit(add_expense_arr){
      if($("#unequal_split").is(':checked')){
        $('#unequalSplit').empty();
        add_expense_arr.forEach(function(data, index){
          var user_name = data[0];
          var user_id = data[1];
          $('#unequalSplit').append("<label name=shares[] for="+user_name+"_"+user_id+" class='unequal_share_label'>"+user_name+"'s Share</label>")
          $('#unequalSplit').append("<input type='text' id="+user_name+"_"+user_id+" name=shares[] data-user-id="+user_id+" class='form-control add_expense_form_inputs'>");
        });
    }
  }

    $('.unequal_checkbox').click(function() {
      if(!$("#unequal_split").is(':checked')){
        $('#unequalSplit').hide();
      }
      else if($("#unequal_split").is(':checked')){
        // $('#unequalSplit').empty();
        $('#unequalSplit').show();
      }
    });
});
