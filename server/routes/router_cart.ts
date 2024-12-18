import express,
    {
        Request,
        Response
    } from 'express';

import Cart from './../models/cart';

import { PrismaClient } from '@prisma/client';

export const ROUTER_CART = express.Router();

const prisma = new PrismaClient();

ROUTER_CART.get('/', async (req: Request, res: Response) => {
    const carts = await prisma.cart.findMany({
        include: {
            Car: true
        },
        where: {
            id_profile: Number(req.body.id_profile),
            is_ordered: false
        }
    });

    if(carts) {
        res.status(200).json(carts);
        return;
    }
    else {
        res.status(404).json({ message: 'Can not find carts item.'});
        return;
    }
});

ROUTER_CART.get('/:id', async (req: Request, res: Response) => {
    const cart = await prisma.cart.findFirst({
        where: {
            id_car: Number(req.params.id),
            id_profile: Number(req.body.id_profile),
            is_ordered: false
        },
        include: {
            Car: true
        }
    });

    if(cart) {
        res.status(200).json(cart);
        return;
    }
    else {
        res.status(204).json({ message: 'Cart not found.' });
        return;
    }
});

ROUTER_CART.post('/', async (req: Request, res: Response) => {
    try {
        const cart = await prisma.cart.create({
            data: {
                id_car: Number(req.body.id),
                quantity: 1,
                id_profile: Number(req.body.id_profile),
                is_ordered: false
            },
            include: {
                Car: true
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Cart can not be created in the database.'});
        return;
    }
});

ROUTER_CART.put('/increase/:id', async (req: Request, res: Response) => {
    try {
        const cart = await prisma.cart.findFirst({
            where: {
                id_car: Number(req.params.id),
                id_profile: Number(req.body.id_profile),
                is_ordered: false
            }
        });

        const updated = await prisma.cart.update({
            where: {
                id: cart!.id,
                id_profile: Number(req.body.id_profile),
                is_ordered: false
            },
            data: {
                quantity: cart!.quantity + 1
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Cart not found.' });
        return;
    }
});

ROUTER_CART.put('/decrease/:id', async (req: Request, res: Response) => {    
    try {
        const cart = await prisma.cart.findFirst({
            where: {
                id_car: Number(req.params.id),
                id_profile: Number(req.body.body),
                is_ordered: false
            }
        });

        if(cart?.quantity === 0) return;

        const updated = await prisma.cart.update({
            where: {
                id: cart!.id,
                id_profile: Number(req.body.body),
                is_ordered: false
            },
            data: {
                quantity: cart!.quantity - 1
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Cart not found.' });
        return;
    }
});

ROUTER_CART.delete('/:id', async (req: Request, res: Response) => {
    try {
        const cart = await prisma.cart.findFirst({
            where: {
                id_car: Number(req.params.id),
                id_profile: Number(req.body.id_profile),
                is_ordered: false
            }
        });

        const deleted = await prisma.cart.delete({
            where: {
                id: cart!.id,
                id_car: cart!.id_car,
                id_profile: cart!.id_profile,
                is_ordered: false
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Can not delete cart from database.' });
        return;
    }
});