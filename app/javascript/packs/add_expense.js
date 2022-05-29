$('document').ready(function(){
  var add_expense_arr =[];
  $('#errorModal').hide();


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
          $('#unequalSplit').append("<label name=shares[] for="+user_name+"_"+user_id+" class='unequal_share_label'>"+user_name+"'s Share in %</label>")
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

    $('.add_expense_form_inputs').on('change', function(){

      var percs= $(".add_expense_form_inputs").map(function() {
        return $(this).val();
      }).get();

    });

    $('#add_expense_submit').on('click', function(event){
      $('#errorsList .error').empty();
      checkParticipants(event);
      checkPercentageValues(event);
      checkBillValue(event);
    });

    function checkParticipants(events){
      var participants = [];
      $('input.participants_checkbox:checkbox:checked').each(function () {
        participants.push($(this).val());
      });
      if(participants.length <= 0)
      {
        setErrorModal(["Pleae select atleast one user"], event)
      }
    }

    function checkBillValue(event){
      var amount = $('#bill_amount').val();
      var msgs = [];
      if(isNaN(amount) || amount == ""){
        msgs.push("Please enter a valid bill amount");
      }
      else{
        if(parseInt(amount) < 0){
          msgs.push("Entered bill amount is negative \""+amount+"\"");
        }
      }
      if(msgs.length > 0){
        setErrorModal(msgs, event)
      }
    }

    function checkPercentageValues(){
      var percs= $(".add_expense_form_inputs").map(function() {
        return $(this).val();
      }).get();

      var msg = [];
      var total_percs = 0;
      for (let i = 0; i < percs.length; i++) {
        var percentage = parseInt(percs[i]);
        if(percentage < 0){
          msg.push("Negative percentage value \""+percentage+"\"");
        }
        if(isNaN(percs[i])){
          msg.push("Entered percentage share value is not a valid number \""+ percs[i]+"\"");
        }
        else{
          total_percs += parseInt(percentage);
        }
      }
      if (total_percs > 100){
        msg.push("Sum of percentages is more than 100");
      }

      if(msg.length > 0){
        setErrorModal(msg, event)
      }
    }

    function setErrorModal(msgs, event){
      event.preventDefault();
      $('#errorModal').show();
      for (let i = 0; i < msgs.length; i++){
        $('#errorsList .error:last').append("<li>"+msgs[i]+"</li>");
      }
    }

    $('.modal-close').on('click', function(){
      $('#errorModal').hide();
    });

});
