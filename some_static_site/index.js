document.addEventListener('DOMContentLoaded', (event) => {
    const form = document.getElementById('form');
    const inputField = document.getElementById('username');
    const displayArea = document.getElementById('displayArea');

    form.addEventListener('submit', (event) => {
        event.preventDefault();
        const userInput = inputField.value;
        displayArea.textContent = `Welcome ${userInput}!!`;
        inputField.value = '';
    });
});