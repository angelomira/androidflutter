import CARS_DATABASE from "../data/cars";
import CART_DATABASE from "../data/cart";

export default class Car {
    id: number;
    carName: string;
    carEntry: string;
    price: string;
    linkImage: string;
    linkRefer: string;
    carDescription: string;
    isFavorite: boolean = false;

    constructor(_id: number, _carName: string, _carEntry: string, _price: string, _linkImage: string, _linkRefer: string, _carDescription: string, _isFavorite = false) {
        this.id = _id;
        this.carName = _carName;
        this.carEntry = _carEntry;
        this.price = _price;
        this.linkImage = _linkImage;
        this.linkRefer = _linkRefer;
        this.carDescription = _carDescription;
        this.isFavorite = _isFavorite;
    }

    update(instance: Car): void {
        this.id = instance.id;
        this.carName = instance.carName;
        this.carEntry = instance.carEntry;
        this.price = instance.price;
        this.linkImage = instance.linkImage;
        this.linkRefer = instance.linkRefer;
        this.carDescription = instance.carDescription;
    }

    updateFavorite(status: boolean | undefined): void {
        this.isFavorite = status ?? !this.isFavorite;
    }

    isInCart(): boolean {
        return CART_DATABASE.find(cart => cart.car.id === this.id) !== undefined;
    }

    delete(): void | undefined {
        if(CARS_DATABASE.includes(this))
            CARS_DATABASE.splice(CARS_DATABASE.findIndex(car => car.id === this.id), 1);
        else
            return undefined;
    }

    static create(obj: any): Car {
        return new Car(Date.now(), obj.carName, obj.carEntry, obj.price, obj.linkImage, obj.linkRefer, obj.carDescription);
    }

    static parse(obj: any): Car {
        return new Car(obj.id, obj.carName, obj.carEntry, obj.price, obj.linkImage, obj.linkRefer, obj.carDescription);
    }
}