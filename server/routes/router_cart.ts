import express,
    {
        Request,
        Response
    } from 'express';

import CART_DATABASE from './../data/cart';

import Cart from './../models/cart';

export const ROUTER_CART = express.Router();

ROUTER_CART.get('/', (req: Request, res: Response) => {
    const carts = CART_DATABASE;

    if(carts) {
        res.status(200).json(carts).send();
        return;
    }
    else {
        res.status(404).json({ message: 'Can not find carts item.'}).send();
        return;
    }
});

ROUTER_CART.get('/:id', (req: Request, res: Response) => {
    const cart = CART_DATABASE.find(cart => cart.car.id === Number(req.params.id));

    if(cart) {
        res.status(200).json(cart).send();
        return;
    }
    else {
        res.status(204).json({ message: 'Cart not found.' }).send();
        return;
    }
});

ROUTER_CART.post('/', (req: Request, res: Response) => {
    const item = Cart.create(req.body);

    if(item instanceof Cart) {
        CART_DATABASE.push(item);

        res.status(201).json({ message: 'Cart added successfully.', item }).send();
        return;
    }
    else {
        res.status(404).json({ message: 'Cart can not be created in the database.'}).send();
        return;
    }
});

ROUTER_CART.put('/increase/:id', (req: Request, res: Response) => {
    const index = CART_DATABASE.findIndex(cart => cart.car.id === Number(req.params.id));

    if(index === -1) {
        res.status(404).json({ message: 'Cart not found.' }).send();
        return;
    }
    else {
        CART_DATABASE[index].increase();

        res.status(201).json({ message: 'Cart updated (increase) successfully.' }).send();
        return;
    }
});

ROUTER_CART.put('/decrease/:id', (req: Request, res: Response) => {
    const index = CART_DATABASE.findIndex(cart => cart.car.id === Number(req.params.id));

    if(index === -1) {
        res.status(404).json({ message: 'Cart not found.' }).send();
        return;
    }
    else {
        CART_DATABASE[index].decrease();

        res.status(201).json({ message: 'Car updated (decrease) successfully.' }).send();
        return;
    }
});

ROUTER_CART.delete('/:id', (req: Request, res: Response) => {
    const index = CART_DATABASE.findIndex(cart => cart.car.id === Number(req.params.id));

    console.log('Catching DELTE!');

    if(index === -1) {
        res.status(404).json({ message: 'Cart not found.' }).send();
        return;
    }
    else {
        console.log(CART_DATABASE);
        const answer = CART_DATABASE[index].delete();
        console.log('-------------- after:')
        console.log(CART_DATABASE);

        if(answer) {
            res.status(204).json({ message: 'Cart removed successfully.' }).send();
            return;
        }
        else {
            res.status(404).json({ message: 'Can not delete cart from database.' }).send();
            return;
        }
    }
});