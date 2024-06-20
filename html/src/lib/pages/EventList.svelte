<script lang="ts">

    import Page from "../components/Page.svelte";
    import {Button, Card} from "flowbite-svelte";
    import {FontAwesomeIcon} from "@fortawesome/svelte-fontawesome";
    import {faPenToSquare} from "@fortawesome/free-solid-svg-icons";
    import CodeJamEvent from "../models/event";
    import {onMount} from "svelte";
    import {getEvents} from "../services/services";
    import {eventStatusStore} from "../stores/stores";
    
    let events: Array<CodeJamEvent> = [];
    let statusesMap: Map<number, string> = new Map();
    
    function editEvent(eventId: string) {
        window.location.href = '/#/admin/event/' + eventId;
    }
    
    function getEventStatus(statusId: number): string {
        return statusesMap.get(statusId) || '';
    }
    
    eventStatusStore.subscribe((eventStatuses) => {
        statusesMap.clear();
        eventStatuses.forEach(status => {
            statusesMap.set(status.Id, status.Title);
        });
    });
    
    onMount(async () => {
        try {
            const response = await getEvents();
            if (response.status === 200) {
                const data = await response.json();
                events = data;
            }
        } catch (error) {
            console.error('Failed to fetch events:', error);
        }
    });
    
    </script>
    
    <Page>
    
        <Card size="xl" class="w-full">
            <h2>My Events</h2>
            <div class="flex flex-col gap-8 my-8">
            </div>
    
            {#each events as event}
                <Card size="xl">
                    <div class="flex flex-row w-full gap-2">
                        <div class="flex grow flex-col">
                            <span class="text-2xl font-bold">{event.Title}</span>
                            <span class="">{getEventStatus(event.StatusId)}</span>
                        </div>
                        <Button class="bg-blue-500 hover:bg-blue-700" on:click={() => editEvent(event.Id)}>Edit <FontAwesomeIcon class="ml-4" icon={faPenToSquare}/></Button>
                    </div>
                </Card>
            {/each}
    
        </Card>
    
    </Page>
    