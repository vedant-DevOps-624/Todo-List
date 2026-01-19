// Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-app.js";
import { getAuth } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-auth.js";

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyBhsK4zze_Zzy1cG0h8pfHGE_SIOaGVi9U",
    authDomain: "todolist-72c6f.firebaseapp.com",
    projectId: "todolist-72c6f",
    storageBucket: "todolist-72c6f.firebasestorage.app",
    messagingSenderId: "99484916038",
    appId: "1:99484916038:web:682200fd6d97f0c6226d47",
    measurementId: "G-XB0PRE289B"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
