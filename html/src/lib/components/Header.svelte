<script lang="ts">

import Banner from "./Banner.svelte";
import {Dropdown, DropdownDivider, DropdownItem, Navbar, NavHamburger, NavLi, NavUl} from "flowbite-svelte";
import {loggedInStore, userStore} from "../stores/stores";
import DiscordIcon from "./DiscordIcon.svelte";
import {location} from "svelte-spa-router";
import {getDiscordAvatarUrl} from "../utils";

// reactive statement - "location" will change whenever url changes 
$: activeUrl = '/#' + $location;
</script>


<style>
    .active-link {
            /* Add your styles here */
            background-color: #f0f0f0; /* Example style */
        }
</style>


<div class="flex flex-row w-fit pl-8">
    <Banner size="normal" />
    <div class="absolute right-0 top-0">
        
        <Navbar class="rounded-bl-3xl">
            <NavHamburger/>
            <NavUl {activeUrl} classUl="items-center px-4 py-1">
                <!-- It is important to prefix links with /#/ to prevent reloading of the entire app -->
                <NavLi href="/#/">Home</NavLi>
                {#if $loggedInStore}
                    {#if $userStore?.Role === "ADMIN" }
                    <NavLi href="/#/admin/events">Manage Events</NavLi>
                    {/if}
                    <NavLi href="/#/team">Sign-Up</NavLi>
                    <img class="rounded-full cursor-pointer border border-2 hover:border-blue-400" src="{getDiscordAvatarUrl($userStore.ServiceUserId, $userStore.AvatarUrl)}">
                    <Dropdown class="w-44 z-20">
                        <DropdownItem href="/">Profile</DropdownItem>
                        <DropdownDivider />
                        <DropdownItem href="/user/logout">Logout</DropdownItem>
                    </Dropdown>
                {:else}
                    <NavLi href="/oauth/redirect">Login with Discord <DiscordIcon/></NavLi>
                {/if}
            </NavUl>
        </Navbar>
    </div>
</div>