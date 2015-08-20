// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui/datepicker
//= require bootstrap
//= require_tree .

$(function () {
  $(document)
    .on('click', '.oi-btn-del', function () {
      $(this).parents('tr').toggleClass('danger');
      var del_flag_id = $(this).attr('del-flag-id');
      $('#' + del_flag_id).val('1');
    })

    .on('click', '#order_one_address', function() {
      $('#cart_shipping_address_block').toggleClass('hidden');
    })

    .on('click', '[name=shipping]', function() {  
      var shipping = Number($(this).val());
      var order_sum = Number($('#order_sum_data').html());
      var total_sum = shipping + order_sum;
      $('#ship_sum_text').html('$' + shipping.toFixed(2));
      $('#order_total_sum_text').html('$' + total_sum.toFixed(2));
    });
    
  $('#rating-bar').on('click', 'input', function(event) {
    var StarNum = parseInt($(this).next().attr('value'));
    $('#rating').attr('value', StarNum);
    for(var i=1; i<=StarNum; i++) {
      $('.rating-star[value = ' + i + ']').removeClass('empty').addClass('marked');
    }
    for(i=StarNum+1; i<=5; i++) {
      $('.rating-star[value = ' + i + ']').removeClass('marked').addClass('empty');
    }
  });
  
  $('#btn-empty-cart').on('click', function(event){
    $('#myModal').modal('show');
  });

  // datepicker
  var d = $('#datepicker-btn');
  
  d.datepicker({
    changeMonth: true,
    changeYear: true,
    showButtonPanel: true,
    showOn: 'button', 
    onClose: function(dateText, inst) { 
      var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
      var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
      var sel_date = new Date(year, month, 1);
      $(this).datepicker('setDate', sel_date);
      $('#expiration-label').val($.datepicker.formatDate('MM yy', sel_date));
      // month is numbered from 0
      $('#expiration_month').val(Number(month)+1);
      $('#expiration_year').val(year);
    }
  });
  // datepicker button
  $('button.ui-datepicker-trigger').addClass('btn btn-default');
  // Initializing expiration label
  var month = $('#expiration_month').val();
  // month is numbered from 0
  month = Number(month)-1;
  var year = $('#expiration_year').val();
  $('#expiration-label').val($.datepicker.formatDate('MM yy', new Date(year, month, 1)));
  
});