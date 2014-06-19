/*global $ */
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip({'placement': 'top'});
  $('[data-toggle="popover"]').popover({trigger: 'hover','placement': 'top'});
  $(function(){
    $('a.comment-form').pjax('#main') // pjax call
    })

});
 
$(document).ready(function () {
   $('.dropdown-toggle').dropdown();

  $('#account_password').strength({
          strengthClass: 'strength',
          strengthMeterClass: 'strength_meter',
          strengthButtonClass: 'button_strength',
          strengthButtonText: 'Show password',
          strengthButtonTextToggle: 'Hide Password'
   });   
 });


$(document).ready(function(){
  var limitnum = 140; // set your int limit for max number of characters
  
  function limiting(obj, limit) {
    var cnt = $("#counter > span");
    var txt = $(obj).val(); 
    var len = txt.length;
    
    // check if the current length is over the limit
    if(len > limit){
       $(obj).val(txt.substr(0,limit));
       $(cnt).html(len-1);
     } 
     else { 
       $(cnt).html(len);
     }
     
     // check if user has less than 20 chars left
     if(limit-len <= 20) {
     	$(cnt).addClass("warning");
     }
     else if (limit-len <= 0){ 
      alert( "sorry you have  have exceed the limit of  140 character");
     }
  }


  $('textarea').keyup(function(){
    limiting($(this), limitnum);
  });
});


$(document).ready(function() {

	/* This is basic - uses default settings */
	
	$(".fancybox").fancybox()

	
});

$(document).ready(function(){
           $('li img').on('click',function(){
                var src = $(this).attr('src');
                var img = '<img src="' + src + '" class="img-responsive"/>';
                $('#myModal').modal();
                $('#myModal').on('shown.bs.modal', function(){
                    $('#myModal .modal-body').html(img);
                });
                $('#myModal').on('hidden.bs.modal', function(){
                    $('#myModal .modal-body').html('');
                });
           });  
        })

!function($) {
  'use strict';

  $(function() {
    function toggleAction(selector, disabled) {
      var method = disabled ? 'addClass' : 'removeClass';
      $(selector)[method]('list-menu-link-disabled').parent()[method]('list-menu-wrapper-disabled');
    }
    // Check/uncheck all functionality
    function checkAll(base, checked) {
      // Toggle all checkboxes on the table's body that exist on the first column.
      base.find(listCheckboxesSelector).prop('checked', checked);
      base.find('.list-row')[checked ? 'addClass' : 'removeClass']('list-row-selected');
      toggleAction('#delete-selected', !checked);
    }
    function generalToggle() {
      var checked = listCheckboxes.filter(':checked').length;
      toggleAction('#delete-selected', checked === 0);
      toggleAction('#deselect-all', checked === 0);
      toggleAction('#select-all', checked === listCheckboxesLength);
    }

    var listCheckboxesSelector = '.list-selectable-checkbox', list = $('#list'), alertTimeout = 4000, listCheckboxes, listCheckboxesLength;

    // Automatically close alerts if there was any present.
    if ($('.alert').length > 0) {
      setTimeout(function() { $('.alert').alert('close'); }, alertTimeout);
    }

    // Only process list-related JavaScript if there's a list!
    if (list.length > 0) {
      listCheckboxes = list.find(listCheckboxesSelector);
      listCheckboxesLength = listCheckboxes.length;
      
      // Confirm before deleting one item
      $('.list-row-action-delete-one').on('click', function(ev) {
        ev.preventDefault();
        $(this).addClass('list-row-action-wrapper-link-active')
          .siblings('.list-row-action-popover-delete-one').first().show()
          .find('.cancel').on('click', function() {

            $(this).parents('.list-row-action-popover-delete-one').hide()
              .siblings('.list-row-action-delete-one').removeClass('list-row-action-wrapper-link-active');
          });
      });

      // Select/deselect record on row's click
      list.find('.list-row').on('click', function(ev) {
        var checkbox, willBeChecked;
        ev.stopPropagation();

        if (ev.currentTarget.tagName == 'TR') { 
          checkbox = $(this).find('.list-selectable-checkbox');
          willBeChecked = !checkbox.prop('checked');
          checkbox.prop('checked', willBeChecked);
          $(this)[willBeChecked ? 'addClass' : 'removeClass']('list-row-selected');
          generalToggle();
        }
      });
      // Select all action 
      $('#select-all').on('click', function(ev) {
        ev.preventDefault();
        ev.stopPropagation();
        if ($(this).is('.list-menu-link-disabled')) return;

        // We assume we want to stay on the dropdown to delete all perhaps
        ev.stopPropagation();
        checkAll(list, true);
        toggleAction('#select-all', true);
        toggleAction('#deselect-all', false);
      });
      // Deselect all action 
      $('#deselect-all').on('click', function(ev) {
        ev.preventDefault();
        if ($(this).is('.list-menu-link-disabled')) return;

        checkAll(list, false);
        toggleAction('#deselect-all', true);
        toggleAction('#select-all', false);
      });
      // Delete selected
      $('#delete-selected').on('click', function(ev) {
        ev.preventDefault();
        ev.stopPropagation();
        if ($(this).is('.list-menu-link-disabled')) return;

        // Open the popup to confirm deletion
        $(this).parent().addClass('active').parent('.dropdown').addClass('open');
        $(this).addClass('active')
          .siblings('.list-menu-popover-delete-selected').first().show()
          .find('.cancel').on('click', function() {
          
            // Hide the popover on cancel
            $(this).parents('.list-menu-popover-delete-selected').hide()
              .siblings('#delete-selected').removeClass('active').parent().removeClass('active');
            // and close the dropdown
            $(this).parents('.dropdown').removeClass('open');
          });

        $(this).siblings('.list-menu-popover-delete-selected').find(':hidden[data-delete-many-ids=true]').
          val(listCheckboxes.filter(':checked').map(function() { return $(this).val(); }).toArray().join(','));
      });

      // Catch checkboxes check/uncheck and enable/disable the delete selected functionality
      listCheckboxes.on('click', function(ev) {
        ev.stopPropagation();

        $(this).parent('.list-row')[$(this).is(':checked') ? 'addClass' : 'removeClass']('list-row-selected');

        generalToggle();
      });
    }

    // Autofocus first field with an error. (usability)
    $('.has-error :input').first().focus();
  });
}(window.jQuery);
$(document).ready(function(){
  $('.logoImage img').each(function(){
        var anchor = $('<a/>').attr({'href': this.src}).colorbox({height: "90%", title: "Your Company Logo"});
        $(this).wrap(anchor); });

  $('[data-toggle="tooltip"]').tooltip({'placement': 'top'});
  $('[data-toggle="popover"]').popover({trigger: 'hover','placement': 'top'});
});
$(document).ready(function() {
			<!-- Real-time Validation -->
				<!--Name can't be blank-->
				$('#account_name').on('input', function() {
					var input=$(this);
					var is_name=input.val();
					if(is_name){input.removeClass("invalid").addClass("valid");}
					else{input.removeClass("valid").addClass("invalid");}
				});
				
       $('#account_user_name').on('input', function() {
					var input=$(this);
					var is_name=input.val();
					if(is_name){input.removeClass("invalid").addClass("valid");}
					else{input.removeClass("valid").addClass("invalid");}
				});
				
        $('#account_surname').on('input', function() {
					var input=$(this);
					var is_name=input.val();
					if(is_name){input.removeClass("invalid").addClass("valid");}
					else{input.removeClass("valid").addClass("invalid");}
				});

				
				<!--Email must be an email -->
				$('#account_email').on('input', function() {
					var input=$(this);
					var re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
					var is_email=re.test(input.val());
					if(is_email){input.removeClass("invalid").addClass("valid");}
					else{input.removeClass("valid").addClass("invalid");}
				});
				
		
			<!-- After Form Submitted Validation-->
			$('#account_save button').click(function(event){
				var form_data=$("#account").serializeArray();
				var error_free=true;
				for (var input in form_data){
					var element=$('#account_'+form_data[input]['name']);
					var valid=element.hasClass("valid");
					var error_element=$("span", element.parent());
					if (!valid){error_element.removeClass("error").addClass("error_show"); error_free=false;}
					else{error_element.removeClass("error_show").addClass("error");}
				}
				if (!error_free){
					event.preventDefault(); 
				}
				else{
					alert('No errors: Form will be submitted');
				}
			});
		});

			
     
