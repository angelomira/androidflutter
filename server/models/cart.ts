import Car from "./car"

export default class Cart {
    car: Car;
    quantity: number;

    constructor(_car: Car, _quantity: 0) {
        this.car = _car;
        this.quantity = _quantity;
    }

    increase(): void {
        this.quantity++;
    }

    decrease(): void {
        if(this.quantity === 1)
            return;
        else
            this.quantity--;
    }
}