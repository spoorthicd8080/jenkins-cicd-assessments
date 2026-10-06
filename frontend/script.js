const statusButton = document.getElementById("statusButton");
const statusMessage = document.getElementById("statusMessage");

statusButton.addEventListener("click", function () {
    statusMessage.textContent = "Application is running successfully!";
    statusMessage.style.color = "green";
});