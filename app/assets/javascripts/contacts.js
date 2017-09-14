if (typeof $ === "function") {
    $(function () {
        $(document).on('click', 'a.delete-contact', function(e){
            var ele = $(this);
            var url = ele.data('url');
            console.log(url);
            $.ajax({
                url: url,
                method: 'delete',
                beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
                error: function(){
                    $.notify({
                        message: 'Unable to delete',
                        title: 'ERROR:',
                        icon: 'fa fa-fire'
                    },{
                        type: 'danger'
                    });
                },
                success: function(){
                    $.notify({
                        message: 'Contact deleted successfully',
                        title: 'SUCCESS:',
                        icon: 'fa fa-check-circle'
                    },{
                        type: 'success'
                    });
                    
                    ele.parents('.contact-panel').remove();
                }
                        
            });
        });
    });
}