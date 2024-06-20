import { activeEventStore, eventStatusStore, userStore } from "../stores/stores";
import CodeJamEvent from "../models/event";

export let baseApiUrl = "";

// Custom fetch function to handle common logic and errors
async function customFetch(url, options = {}) {
    const fullUrl = `${baseApiUrl}${url}`;
    try {
        const response = await fetch(fullUrl, { credentials: 'include', ...options });
        if (!response.ok) {
            if (response.status === 401) {
                userStore.set(null);
            }
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response;
    } catch (error) {
        console.error('Fetch error:', error, url, options);
        throw error; // Re-throw to allow specific handlers in calling functions to react
    }
}

export async function getUser() {
    try {
        const response = await customFetch("/user/");
        const data = await response.json();
        userStore.set(data);
    } catch (error) {
        console.error("Error deserializing user", error);
    }
}

export async function logout() {
    try {
        await customFetch("/user/logout");
        userStore.set(null);
    } catch (error) {
        console.error("Logout error", error);
    }
}

export async function getActiveEvent() {
    try {
        const response = await customFetch("/event/active");
        if (response.status === 204) {
            activeEventStore.set(null);
        } else {
            const data = await response.json();
            activeEventStore.set(data as CodeJamEvent);
        }
    } catch (error) {
        console.error("Error deserializing event", error);
    }
}

export async function getEvents() {
    return await customFetch("/event/");
}

export async function getEvent(id: string) {
    return await customFetch(`/event/${id}`);
}

export async function putEvent(event: CodeJamEvent) {
    return await customFetch(`/event/${event.Id}`, {
        method: "PUT",
        body: JSON.stringify(event),
        headers: {'Content-Type': 'application/json'}
    });
}

export async function getEventStatuses() {
    try {
        const response = await customFetch("/event/statuses");
        const data = await response.json();
        eventStatusStore.set(data);
    } catch (error) {
        console.error("Error fetching event statuses", error);
    }
}

async function initialLoad() {
    await Promise.all([getUser(), getActiveEvent(), getEventStatuses()]);
}

initialLoad();
