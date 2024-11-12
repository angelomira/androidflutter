import Cart from "../models/cart";

/**
 * A dictionary holding cart instances personalized for each user profile in the shop.\n
 * Each profile ID is associated with a specific cart instance. 
 * 
 * @type {{ [id: number]: Cart }} 
 * @property {number} id - The unique identifier of a user profile, corresponding to ID of profile.
 * @property {Cart} Cart - The cart instance associated with the user profile.
 */
const CART_PROFILIZED_DATABASE: { [id: number]: Cart } = {};