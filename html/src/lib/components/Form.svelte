<script lang="ts">

    import {setContext} from "svelte";
    import {toast} from "svelte-sonner";

    class FormFieldRef {
        name: string;
        errorFunction: (msg: string) => {};

        constructor(name: string, errorFunction: (msg: string) => {}) {
            this.name = name;
            this.errorFunction = errorFunction;
        }
    }

    let fields: Map<string, FormFieldRef> = new Map();

    setContext('formFunctions', {
        register: (name: string, errorFunction: (msg: string) => {}) => {
            fields.set(name, new FormFieldRef(name, errorFunction));
        }
    });

    function SetFieldError(fieldName: string, error: string) {
        const field = fields.get(fieldName);
        if (field) {
            field.errorFunction(error);
        }
    }

    export const clearErrors = () => {
        fields.forEach((item) => {
            item.errorFunction('');
        });
    }

    export const parseResponse = (response: Response) => {
        if (response.status === 200) {
            toast.success("Event Saved Successfully!");
        } else {
            toast.error("Error Saving.");
            response.json()
                .then((data) => {
                    data.Errors.forEach((error) => {
                        SetFieldError(error.Field, error.Error);
                    });
                })
                .catch((err) => {
                    console.error(err);
                });
        }
    }

</script>

<slot/>
