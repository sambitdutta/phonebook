$(function() {
    $('#side-menu').metisMenu();
});

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function() {
    $(window).bind("load resize", function() {
        var topOffset = 50;
        var width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        var height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });
    var url = window.location.toString();
    var element = $('ul.nav a').filter(function() {
        return this.href == url;
    }).addClass('active').parent();
    if (element.length == 0){
      var origin = window.location.origin;
      var paths = window.location.pathname.split("/") // no submenu - show anyway
      for (var i=paths.length; i>1; i--) {
        url = origin + "/" + paths.slice(1,i).join("/")
        var element = $('ul.nav a').filter(function() {
            return this.href == url;
        }).addClass('active').parent();
        if (element.length > 1){
          break;
        }
      }
    }
    while (true) {
        if (element.is('li')) {
            element = element.parent().addClass('in').parent().addClass('active');
        } else {
            break;
        }
    }
});
