export default class Profile {
    id: number;
    name: string;
    surname: string;
    middlename: string;
    dateBorn: Date;
    email: string;
    avatarLink: string = 'https://via.placeholder.com/160';
    avatarFile?: File;

    constructor(_id: number, _name: string, _surname: string, _middlename: string, _dateBorn: Date, _email: string, _avatarLink?: string, _avatarFile?: File) {
        this.id = _id;
        this.name = _name;
        this.surname = _surname;
        this.middlename = _middlename;
        this.dateBorn = _dateBorn;
        this.email = _email;
        this.avatarLink = _avatarLink ?? 'https://via.placeholder.com/160';
        this.avatarFile = _avatarFile ?? undefined;
    }

    static create(obj: any) {
        return new Profile(Date.now(), obj.name, obj.surname, obj.middlename, new Date(obj.dateBorn), obj.email, obj.avatarLink, obj.avatarFile);
    }

    static parse(obj: any) {
        return new Profile(obj.id, obj.name, obj.surname, obj.middlename, new Date(obj.dateBorn), obj.email, obj.avatarLink, obj.avatarFile);
    }

    static example() {
        return new Profile(
            Date.now(),
            'Unknown server response.',
            'Unknown server response.',
            'Unknown server response.',
            new Date(),
            'Unknown server response.'
        );
    }

    update(instance: Profile): void {
        this.name = instance.name;
        this.surname = instance.surname;
        this.middlename = instance.middlename;
        this.email = instance.email;
        this.avatarLink = instance.avatarLink;
        this.avatarFile = instance.avatarFile;
        this.dateBorn = instance.dateBorn;
    }
}