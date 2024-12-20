<script setup>
import { defineProps, defineEmits } from 'vue';

defineProps({
    users: {
        type: Array,
        required: true,
    },
});

const emit = defineEmits();

const updateStatus = (user, status) => {
    emit('status-updated', { user, status });
};
</script>


<template>
    <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Name
                </th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Email
                </th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Status
                </th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Actions
                </th>
            </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="user in users" :key="user.id">
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ user.name }}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ user.email }}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm">
            <span
                :class="[
                'px-2 inline-flex text-xs leading-5 font-semibold rounded-full',
                user.enabled ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
              ]"
            >
              {{ user.enabled ? 'Enabled' : 'Disabled' }}
            </span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    <button
                        v-if="!user.enabled"
                        class="px-4 py-2 mr-2 text-white bg-blue-500 hover:bg-blue-700 rounded"
                        @click="updateStatus(user, 'enabled')"
                    >
                        Enable
                    </button>
                    <button
                        v-if="user.enabled"
                        class="px-4 py-2 text-white bg-red-500 hover:bg-red-700 rounded"
                        @click="updateStatus(user, 'disabled')"
                    >
                        Disable
                    </button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

