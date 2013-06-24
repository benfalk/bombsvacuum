$(function(){
    $('*[data-modal-id]').click(function(){
        modalPop($(this).data('modal-id'));
    });

    $('.close-modal').click(function(){
       $('.modal-glaze').hide();
       $('.modal').hide();
    });
    if (boom){
        modalPop('boom');
    }
});

function modalPop(id)
{
    var modal = $('#'+id);
    modal.show().appendTo('#grid');
    modal.wrap('<div class="modal-glaze" />')
}

