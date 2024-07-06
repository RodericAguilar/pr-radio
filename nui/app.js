window.addEventListener('load', () => {
    console.log('NUI Loaded');
    $.post(`https://${GetParentResourceName()}/getAnimations`);
});


window.addEventListener('message', function(event) {
    var v = event.data;
    switch (v.action) {
        case 'open':
            $('.container').fadeIn(50);
            break;

        case 'play_sound':
            let tipoSound = null
            if (v.tipo === 'on') {
                tipoSound = 'soundInicial';
                $('#audio_on').attr('src', localStorage.getItem(tipoSound) || 'sounds/on.ogg');
            } else {
                tipoSound = 'soundFinal'
                $('#audio_off').attr('src', localStorage.getItem(tipoSound) || 'sounds/off.ogg');
            }
            var audioElement = document.getElementById(v.sound);
            audioElement.load();
            audioElement.volume = localStorage.getItem('volume') || 0.5;
            audioElement.addEventListener('canplaythrough', function() {
                audioElement.play();
            });
        break;

        case 'addAnimation':
            $('.opciones').append(`
                <option>${v.label}</option>
            `)
        break;
    }
});
 
$(document).keyup((e) => {
    if (e.key === 'Escape') {
       CloseAll();
    }
});

function CloseAll() {
    $('.container').fadeOut(50);
    $.post(`https://${GetParentResourceName()}/exit`);
    // $('.numeros').val('');
}

$('.boton').click(function() {
    let textButton = $('.boton').text();
    if (textButton === 'Disconnect') {
        $.post(`https://${GetParentResourceName()}/connect`, JSON.stringify({
            channel: 0
        }));
        $('.boton').text('Connect');
    } else {
        let channel = $('.numeros').val();
        if (channel <= 0) {
           $.post(`https://${GetParentResourceName()}/error`, JSON.stringify({
               error: 'Put a valid number'
           }));
        } else {
            $.post(`https://${GetParentResourceName()}/connect`, JSON.stringify({
                channel: channel
            }));
            $('.boton').text('Disconnect');
        }
    }
});

$(".radio-volume").change(function() {
    var volume = $(this).val();
    $.post(`https://${GetParentResourceName()}/volume`, JSON.stringify({
        volume: volume
    }));
});

$(".click-volume").change(function() {
    var volume = $(this).val();
    localStorage.setItem('volume', volume);
});

$('.opciones').on('change', function (e) {
    var optionSelected = $("option:selected", this);
    var valueSelected = this.value;
    $.post(`https://${GetParentResourceName()}/saveAnimation`, JSON.stringify({
        animation: valueSelected
    }));
});

$('.sonidoInicial').on('input',function(e){
    var value = e.target.value;
    // $.post(`https://${GetParentResourceName()}/saveSound`, JSON.stringify({
    //     sound: value,
    //     tipo: 'inicial'
    // }));
    localStorage.setItem('soundInicial', value);
});

$('.sonidofinal').on('change', function (e) {
    var valueSelected = this.value;
    // $.post(`https://${GetParentResourceName()}/saveSound`, JSON.stringify({
    //     sound: valueSelected,
    //     tipo: 'final'
    // }));
    localStorage.setItem('soundFinal', valueSelected);
});