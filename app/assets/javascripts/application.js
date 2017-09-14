// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
// located under vendor/assets
//= require node_modules
// located under app/assets
//= require oracle_admin
//= require custom


function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).before(content.replace(regexp, new_id));
}

function remove_fields(ele, parent) {
    ele.parents(parent).hide();
    ele.prev("input[type='hidden']").val("1");
}


$(function () {

    $(document).on("click", "a.remove-phone-field, a.remove-address-field", function (e) {
        var ele = $(e.target);

        if (ele.hasClass("remove-phone-field")) {
            if ($('.phone-field').length > 1) {
                remove_fields(ele, '.phone-field');

            }
        } else if (ele.hasClass("remove-address-field")) {
            //if($('.address-field').length > 1){
            remove_fields(ele, '.address-field');
            //}
        }
    });

});
