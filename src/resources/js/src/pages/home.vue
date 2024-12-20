<script setup>
import { ref, onMounted } from 'vue';
import UserTable from "../components/UserTable.vue"
import { toaster } from '../utils/toaster.js';
import axios from 'axios';

const users = ref([]);


const fetchUsers = async () => {
    try {
        const response = await axios.get('/users');
        users.value = response.data;
    } catch (error) {
        toaster.error('Failed to fetch users');
    }
};


const updateUserStatus = async ({ user, status }) => {

    const route = status === 'enabled'
        ? `/users/enable/${user.id}`
        : `/users/disable/${user.id}`;

    try {
        const response = await axios.post(route, {}, { headers: { 'Content-Type': 'application/json' } });
        user.enabled = response.data.enabled;
        let action = response.data.enabled ? 'enabled' : 'disabled';
        toaster.success(`user ${action} successfully`);
    } catch (error) {
        toaster.error('Error occurred');
    }
};

onMounted(fetchUsers);
</script>

<template>
    <div class="w-full min-h-screen bg-gray-100 p-4">
        <h1 class="text-xl font-bold mb-4 text-center bg-white py-2">User Management</h1>
        <UserTable :users="users" @status-updated="updateUserStatus" />
    </div>
</template>


