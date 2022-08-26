/** 
 * https://github.com/aamirafridi/jQuery.Marquee
 *
 *  .js-marquee {
 *     display: block;
 *     min-width: 100vw; // fixes "inspringen" van tekst
 *  }
*/
window.onload = initMarquees();

function initMarquees() {
    var $mq = jQuery('.ticker-text').marquee({
        // duration: 5000, //duration in milliseconds of the marquee
        speed: 100,
        gap: 50, //gap in pixels between the tickers
        delayBeforeStart: 0,  //time in milliseconds before the marquee will start animating
        direction: 'left', //'left' or 'right'
        duplicated: true         //true or false - should the marquee be duplicated to show an effect of continues flow
    });
} 