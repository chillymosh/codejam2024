<script lang="ts">
import { 
    Input, 
    Label, 
    Helper,
    Radio, 
    Textarea,
    MultiSelect } from 'flowbite-svelte';

    interface Selections {
        value: string,
        name: string;
    }

    let selectedLangs: Selections[] = [];
    let languages: Selections[] = [
        { value: 'py', name: 'Python'},
        { value: 'ph', name: 'PHP'},
        { value: 'js', name: 'JavaScript'},
        { value: 'ts', name: 'TypeScript'}, 
        { value: 'go', name: 'Go'}
    ];
    let languageValues: string[] = languages.map(language => language.value)

    
    let selectedTZ: Selections[] = [];
    let listTZ: Selections[] = [
        { value: 'PST', name: 'PST -0700'},
        { value: 'MST', name: 'MST -0600'},
        { value: 'EST', name: 'EST -0400'},
    ]
    let tzValues: string[] = listTZ.map(tz => tz.value)
    let textareaprops = {
        id: 'message',
        name: 'message',
        label: 'What do you want out of this team:',
        rows: 4,
        placeholder: "I want to use threejs so I can learn it!"
    };

</script>

<div>
    <h1>Create New Team</h1>
    <Label for="team-name">Team Name</Label>
    <Input id="team-name" />

    <br>
    <Radio name="team-type">Public Team</Radio>
    <Helper>If you want your team to be searchable</Helper>
    <Radio name="team-type">Private Team</Radio>
    <Helper>Your team will be invite only</Helper>

    <MultiSelect id="multi-close" items={languages} bind:value={languageValues} />
    
    <!-- user timezone info will just be displayed for fun -->
    <MultiSelect items={listTZ} bind:value={tzValues} />
    <Label for="tzInput">General Availability:</Label>
    <Input id="tzInput"/>

    <Label for="aboutTextArea">What do you want out of this team?</Label>
    <Textarea {...textareaprops} />

    
</div>