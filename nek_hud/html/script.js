var EnableJobHTML = true;
var EnableHourHTML = true;
var EnableIdHTML = true;
var EnablePlayerHTML = true;

window.addEventListener('message', (event) => {
    let jobPlayer = event.data.playerJob;
    let hourPlayer = event.data.playerHour;
    let idPlayer = event.data.playerId;
    let healthPlayer = event.data.playerHealth;
    let hungherPlayer = event.data.playerHungher;
    let thirstPlayer = event.data.playerThirst;
    let stressPlayer = event.data.playerStress;
    let jobHTML = document.getElementById("job");
    let hourHTML = document.getElementById("hour");
    let idHTML = document.getElementById("id");
    let healthHTML = document.getElementById("health");
    let hungherHTML = document.getElementById("hungher");
    let thirstHTML = document.getElementById("thirst");
    let stressHTML = document.getElementById("stress");
    let playerHTML = document.getElementById("player");

    if(event.data.jobValue === true) {
        EnableJobHTML = true;
    } else if(event.data.jobValue === false) {
        EnableJobHTML = false;
    }

    if(EnableJobHTML === true) {
        jobHTML.style.opacity = 1;
        jobHTML.innerHTML = jobPlayer;
    } else if(EnableJobHTML === false) {
        jobHTML.style.opacity = 0;
    }

    if(event.data.playerValue === true) {
        EnablePlayerHTML = true;
    } else if(event.data.playerValue === false) {
        EnablePlayerHTML = false;
    }

    if(EnablePlayerHTML === true) {
        hungherHTML.style.opacity = 1;
        hungherPlayer = Math.round(hungherPlayer);
        hungherHTML.innerHTML = "&#127789;: " + hungherPlayer;

        thirstHTML.style.opacity = 1;
        thirstPlayer = Math.round(thirstPlayer);
        thirstHTML.innerHTML = "&#128166;: " + thirstPlayer;

        if (stressPlayer === false) {
            playerHTML.style.height = '16.5%';
            playerHTML.style.bottom = '5.7%';
            stressHTML.style.opacity = 0;
        } else {
            playerHTML.style.height = '20%';
            playerHTML.style.bottom = '2.6%';
            stressHTML.style.opacity = 1;
            stressPlayer = Math.round(stressPlayer);
            stressHTML.innerHTML = "&#129504;: " + stressPlayer;
        }

        healthHTML.style.opacity = 1;
        healthPlayer = healthPlayer - 100;
        if(healthPlayer === -100) {
            healthHTML.innerHTML = "&#128128;";
        } else {
            healthHTML.innerHTML = "&#128151;: " + healthPlayer;
        }

        idHTML.style.opacity = 1;
        idHTML.innerHTML = "<i class='fas fa-portrait' style=color: #29DA31;></i>  :  " + idPlayer;
        playerHTML.style.opacity = 1;

    } else if(EnablePlayerHTML === false) {
        playerHTML.style.opacity = 0;
    }

    if(event.data.hourValue === true) {
        EnableHourHTML = true;
    } else if(event.data.hourValue === false) {
        EnableHourHTML = false;
    }

    if(EnableHourHTML === true) {
        hourHTML.style.opacity = 1;
        hourHTML.innerHTML = hourPlayer;
    } else if(EnableHourHTML === false) {
        hourHTML.style.opacity = 0;
    }
})