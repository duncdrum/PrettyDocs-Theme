/*!
 * exist-documentation-5 v4.1.0
 * My amazing exist-documentation-5 application
 * (c) 2019 Duncan Paterson
 * LGPL-3.0 License
 * https://github.com/duncdrum/PrettyDocs-Theme
 */

$(document).ready((function() {

    /* ===== Stickyfill ===== */
    /* Ref: https://github.com/wilddeer/stickyfill */
    // Add browser support to position: sticky
    var elements = $('.sticky');
    Stickyfill.add(elements);


    /* Hack related to: https://github.com/twbs/bootstrap/issues/10236 */
    $(window).on('load resize', (function() {
        $(window).trigger('scroll');
    }));

    /* Activate scrollspy menu */
    $('body').scrollspy({target: '#doc-menu', offset: 100});



    /* ======= jQuery Responsive equal heights plugin ======= */
    /* Ref: https://github.com/liabru/jquery-match-height */

    // $('#cards-wrapper .item-inner').matchHeight();
    // $('#showcase .card').matchHeight();

    /* Bootstrap lightbox */
    /* Ref: http://ashleydw.github.io/lightbox/ */

    $(document).delegate('*[data-toggle="lightbox"]', 'click', (function(e) {
        e.preventDefault();
        $(this).ekkoLightbox();
    }));


}));
