function redirectToTelegram() {
    if (confirm("You will be redirected to Telegram. Continue?")) {
        window.location.href = "https://t.me/guanyin_lite";
    }
}

const downloadBoxes = document.querySelectorAll('.downloadBox, .downloadBox2');

downloadBoxes.forEach(function(downloadBox) {

    downloadBox.addEventListener('click', function() {

        const warningMessage = this.nextElementSibling;

        warningMessage.classList.add('show');

        alert("Locked");
    });
});