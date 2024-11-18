// seed.js

import { PrismaClient } from '@prisma/client';
import Profile from '../models/profile';

const prisma = new PrismaClient();

async function main() {

    await prisma.profile.create({
        data: {
            email: 'data@.com',
            password: '123',
            name: 'profile.name',
            surname: 'profile.surname',
            middlename: 'profile.middlename',
            dateborn: Date.now().toString(),
            avatarLink: ''
        }
    });
}

main()
    .catch(e => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();

        console.debug(`${Date.now()} - Inserted cars data!`);
    });