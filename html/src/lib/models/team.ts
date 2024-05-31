
class CodeJamTeam {

    Id : string;
    EventId: string;
    OwnerUserId : number;
    Name: string;
    Visibility: string;
    Technologies: string;
    Availability: string;
    Description: string;

    constructor() {
        this.Id = '';
        this.EventId = '';
        this.OwnerUserId = 0;
        this.Name = '';
        this.Visibility = '';
        this.Technologies = '';
        this.Availability = '';
        this.Description = '';
    }
}

export default CodeJamTeam;