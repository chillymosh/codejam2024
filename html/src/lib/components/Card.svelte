<script lang="ts">
    import { Avatar, Button } from 'flowbite-svelte';
    let logo = '/static/toast1.png'
</script>
<style>
    .team-card {
        border-radius: 25px;
        background-color: var(--card-color);
        margin-left: 3rem;
        margin-right: 3rem;
    }
</style>

<div class="team-card card">
    <div class="flex col">
        
        <div class="flex row"><img style="width: 20px;" alt="TeamBudgie Logo" src={logo}/> Team Budgie</div>
        <ul>
            <li>logo</li>
            <li>discord usernames: 'timeenjoyed, ambivalentbunnie'</li>
            <li>selected languages: 'python, javascript, go'</li>
            <li>teammate's goals: 'learn threejs'</li>
        </ul>
        <Button>Join Team</Button>
    </div>
</div>