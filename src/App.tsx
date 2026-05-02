/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import React, { useState } from 'react';
import { 
  Home as HomeIcon, 
  LayoutGrid, 
  ShoppingBag, 
  User, 
  Menu, 
  Search, 
  ArrowLeft, 
  ShoppingBasket,
  Star,
  Plus,
  Minus,
  Heart,
  ChevronRight,
  Sparkles
} from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import { CANDIES, CATEGORIES, Candy } from './constants';

type Screen = 'HOME' | 'SHOP' | 'BAG' | 'DETAILS';

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>('HOME');
  const [selectedCandy, setSelectedCandy] = useState<Candy | null>(null);
  const [cart, setCart] = useState<{ candy: Candy, quantity: number }[]>([]);

  const navigateToDetails = (candy: Candy) => {
    setSelectedCandy(candy);
    setCurrentScreen('DETAILS');
  };

  const addToCart = (candy: Candy, quantity: number = 1) => {
    setCart(prev => {
      const existing = prev.find(item => item.candy.id === candy.id);
      if (existing) {
        return prev.map(item => 
          item.candy.id === candy.id 
            ? { ...item, quantity: item.quantity + quantity } 
            : item
        );
      }
      return [...prev, { candy, quantity }];
    });
  };

  const updateCartQuantity = (candyId: string, delta: number) => {
    setCart(prev => prev.map(item => {
      if (item.candy.id === candyId) {
        return { ...item, quantity: Math.max(0, item.quantity + delta) };
      }
      return item;
    }).filter(item => item.quantity > 0));
  };

  const cartTotal = cart.reduce((acc, item) => acc + (item.candy.price * item.quantity), 0);

  return (
    <div className="min-h-screen bg-background relative overflow-hidden flex flex-col items-center">
      <div className="w-full max-w-md bg-background shadow-2xl min-h-screen flex flex-col relative">
        
        {/* Header */}
        <header className="sticky top-0 z-40 bg-orange-50/80 sugar-glass border-b border-primary/5 px-6 py-4 flex justify-between items-center shadow-sm">
          <motion.button 
            whileHover={{ scale: 1.1 }} 
            whileTap={{ scale: 0.9 }}
            className="text-primary"
            onClick={() => currentScreen === 'DETAILS' ? setCurrentScreen('SHOP') : null}
          >
            {currentScreen === 'DETAILS' ? <ArrowLeft size={24} /> : <Menu size={24} />}
          </motion.button>
          
          <h1 className="text-2xl font-black italic text-primary tracking-tighter">CandyLand</h1>
          
          <motion.button whileHover={{ scale: 1.1 }} whileTap={{ scale: 0.9 }} className="text-primary">
            <Search size={24} />
          </motion.button>
        </header>

        <main className="flex-grow pb-32 overflow-y-auto no-scrollbar">
          <AnimatePresence mode="wait">
            {currentScreen === 'HOME' && (
              <motion.div key="home" className="h-full">
                <HomeScreen onSelectCandy={navigateToDetails} />
              </motion.div>
            )}
            {currentScreen === 'SHOP' && (
              <motion.div key="shop" className="h-full">
                <ShopScreen onSelectCandy={navigateToDetails} />
              </motion.div>
            )}
            {currentScreen === 'BAG' && (
              <motion.div key="bag" className="h-full">
                <BagScreen 
                  cart={cart} 
                  onUpdateQuantity={updateCartQuantity} 
                  total={cartTotal} 
                />
              </motion.div>
            )}
            {currentScreen === 'DETAILS' && selectedCandy && (
              <motion.div key="details" className="h-full">
                <DetailsScreen 
                  candy={selectedCandy} 
                  onAdd={(qty) => {
                    addToCart(selectedCandy, qty);
                    setCurrentScreen('BAG');
                  }}
                />
              </motion.div>
            )}
          </AnimatePresence>
        </main>

        {/* Bottom Nav */}
        <nav className="fixed bottom-0 w-full max-w-md z-50 px-4 pb-6 pt-3 sugar-glass rounded-t-[40px] shadow-[0_-10px_30px_rgba(255,157,206,0.15)] border-t border-primary/5 flex justify-around items-center">
          <NavButton 
            active={currentScreen === 'HOME'} 
            onClick={() => setCurrentScreen('HOME')} 
            icon={<HomeIcon />} 
            label="Home" 
          />
          <NavButton 
            active={currentScreen === 'SHOP'} 
            onClick={() => setCurrentScreen('SHOP')} 
            icon={<LayoutGrid />} 
            label="Shop" 
          />
          <NavButton 
            active={currentScreen === 'BAG'} 
            onClick={() => setCurrentScreen('BAG')} 
            icon={
              <div className="relative">
                <ShoppingBag />
                {cart.length > 0 && (
                  <span className="absolute -top-1 -right-1 w-4 h-4 bg-primary text-white text-[10px] rounded-full flex items-center justify-center font-bold">
                    {cart.reduce((a, b) => a + b.quantity, 0)}
                  </span>
                )}
              </div>
            } 
            label="Bag" 
          />
          <NavButton 
            active={false} 
            onClick={() => {}} 
            icon={<User />} 
            label="Account" 
          />
        </nav>

        {/* Floating Action Button - Only on Home */}
        {currentScreen === 'HOME' && (
          <motion.button
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            whileHover={{ scale: 1.1 }}
            whileTap={{ scale: 0.9 }}
            className="fixed bottom-28 right-4 w-14 h-14 bg-primary text-white rounded-full jelly-shadow flex items-center justify-center z-40"
          >
            <ShoppingBasket size={24} />
          </motion.button>
        )}
      </div>
    </div>
  );
}

function NavButton({ active, onClick, icon, label }: { active: boolean, onClick: () => void, icon: React.ReactNode, label: string }) {
  return (
    <motion.button
      onClick={onClick}
      whileTap={{ scale: 0.9 }}
      className={`flex flex-col items-center justify-center px-4 py-2 rounded-full transition-all duration-300 ${active ? 'bg-primary-container/40 text-primary scale-110 shadow-inner' : 'text-primary/40'}`}
    >
      {icon}
      <span className="text-[10px] font-bold uppercase tracking-tight mt-1">{label}</span>
    </motion.button>
  );
}

// --- Screens ---

function HomeScreen({ onSelectCandy }: { onSelectCandy: (c: Candy) => void }) {
  return (
    <div className="p-6 space-y-8">
      {/* Hero Banner */}
      <section className="relative h-48 rounded-[2rem] overflow-hidden jelly-shadow group">
        <img 
          src="https://images.unsplash.com/photo-1534073133331-c4b62bf0d938?auto=format&fit=crop&q=80&w=800" 
          className="absolute inset-0 w-full h-full object-cover"
          alt="Summer Sale"
        />
        <div className="absolute inset-0 bg-gradient-to-r from-primary/80 to-transparent flex flex-col justify-center px-6 space-y-1">
          <span className="bg-tertiary-container text-on-tertiary-container text-[10px] font-black uppercase px-3 py-1 rounded-full w-fit">Summer Limited</span>
          <h2 className="text-3xl font-black text-white leading-none">Sweet Summer Sale</h2>
          <p className="text-white/90 text-sm">Get 20% off all gummies!</p>
          <button className="bg-white text-primary font-bold text-sm px-6 py-2 rounded-full w-fit mt-3 shadow-lg active:scale-95 transition-transform">Shop Now</button>
        </div>
      </section>

      {/* Categories */}
      <section className="space-y-4">
        <div className="flex justify-between items-center px-2">
          <h3 className="text-xl font-extrabold">Sweet Categories</h3>
          <button className="text-primary text-sm font-bold">View All</button>
        </div>
        <div className="flex gap-4 overflow-x-auto no-scrollbar pb-2">
          {CATEGORIES.map((cat, i) => (
            <motion.div 
              key={i} 
              whileTap={{ scale: 0.9 }}
              className="flex flex-col items-center gap-2 flex-shrink-0 group cursor-pointer"
            >
              <div className="w-16 h-16 rounded-full bg-primary-container/20 flex items-center justify-center text-primary group-hover:bg-primary group-hover:text-white transition-all shadow-sm">
                <Sparkles size={28} />
              </div>
              <span className="text-xs font-bold text-on-surface-variant">{cat.name}</span>
            </motion.div>
          ))}
        </div>
      </section>

      {/* Daily Delights */}
      <section className="space-y-4">
        <h3 className="text-xl font-extrabold px-2">Daily Delights</h3>
        <div className="grid grid-cols-2 gap-4">
          {CANDIES.slice(0, 4).map(candy => (
            <CandyCard key={candy.id} candy={candy} onClick={() => onSelectCandy(candy)} />
          ))}
        </div>
      </section>
    </div>
  );
}

function ShopScreen({ onSelectCandy }: { onSelectCandy: (c: Candy) => void }) {
  const lollies = CANDIES.filter(c => c.category === 'Lollies');
  return (
    <div className="p-6 space-y-6">
      <div className="mb-4">
        <h2 className="text-4xl font-extrabold text-primary">Lollies</h2>
        <p className="text-on-surface-variant font-medium">Sweet, sour, and swirl-tastic pops.</p>
      </div>

      {/* Filter Bar */}
      <div className="flex gap-2 overflow-x-auto no-scrollbar">
        {['Price', 'Flavor', 'Size'].map(filter => (
          <button key={filter} className="flex items-center gap-1 px-4 py-2 bg-surface-container-high rounded-full border border-primary/5 text-sm font-bold">
            {filter}
          </button>
        ))}
      </div>

      <div className="grid grid-cols-2 gap-4">
        {lollies.map(candy => (
          <CandyCard key={candy.id} candy={candy} onClick={() => onSelectCandy(candy)} />
        ))}
      </div>
    </div>
  );
}

function BagScreen({ cart, onUpdateQuantity, total }: { cart: { candy: Candy, quantity: number }[], onUpdateQuantity: (id: string, d: number) => void, total: number }) {
  return (
    <motion.div 
      initial={{ opacity: 0, y: 20 }} 
      animate={{ opacity: 1, y: 0 }} 
      exit={{ opacity: 0, y: -20 }}
      className="p-6 space-y-8"
    >
       <div className="flex items-center gap-3">
        <ShoppingBag className="text-primary" size={32} />
        <h2 className="text-3xl font-extrabold">Sweet Bag</h2>
      </div>

      {cart.length === 0 ? (
        <div className="text-center py-20 opacity-50 flex flex-col items-center gap-4">
          <ShoppingBasket size={64} />
          <p className="font-bold">Your bag is empty!</p>
          <button className="text-primary font-black underline">Go Shopping</button>
        </div>
      ) : (
        <>
          <div className="space-y-4">
            {cart.map(item => (
              <div key={item.candy.id} className="bg-white rounded-[1.5rem] p-4 border border-primary/5 jelly-shadow flex gap-4 items-center relative overflow-hidden group">
                <div className="w-24 h-24 rounded-2xl bg-surface-container overflow-hidden flex-shrink-0">
                  <img src={item.candy.image} className="w-full h-full object-cover" alt={item.candy.name} />
                </div>
                <div className="flex-grow">
                  <h3 className="font-bold text-lg leading-tight">{item.candy.name}</h3>
                  <p className="text-xs text-on-surface-variant">Flavor: {item.candy.subcategory}</p>
                  <div className="flex justify-between items-end mt-2">
                    <div className="flex items-center bg-surface-container rounded-full px-2 py-1 gap-4">
                      <button onClick={() => onUpdateQuantity(item.candy.id, -1)} className="text-primary"><Minus size={16} /></button>
                      <span className="font-black text-primary">{item.quantity}</span>
                      <button onClick={() => onUpdateQuantity(item.candy.id, 1)} className="text-primary"><Plus size={16} /></button>
                    </div>
                    <span className="font-extrabold text-primary text-xl">${(item.candy.price * item.quantity).toFixed(2)}</span>
                  </div>
                </div>
              </div>
            ))}
          </div>

          <div className="bg-surface-container-low rounded-[1.5rem] p-6 space-y-4">
            <SummaryRow label="Subtotal" value={`$${total.toFixed(2)}`} />
            <SummaryRow label="Sweet Delivery" value="$1.50" />
            <div className="h-px bg-primary/10 w-full" />
            <div className="flex justify-between items-center">
              <span className="font-bold">Total</span>
              <span className="text-2xl font-black text-primary">${(total + 1.5).toFixed(2)}</span>
            </div>
          </div>

          <button className="w-full py-5 bg-primary text-white rounded-full font-black text-xl shadow-[0_8px_0_#762b56] active:translate-y-2 active:shadow-none transition-all uppercase tracking-widest flex items-center justify-center gap-3">
            Place Sweet Order
            <Sparkles size={24} />
          </button>
        </>
      )}
    </motion.div>
  );
}

function SummaryRow({ label, value }: { label: string, value: string }) {
  return (
    <div className="flex justify-between items-center text-on-surface-variant">
      <span className="font-bold text-sm tracking-wide">{label}</span>
      <span className="font-semibold">{value}</span>
    </div>
  );
}

function DetailsScreen({ candy, onAdd }: { candy: Candy, onAdd: (qty: number) => void }) {
  const [qty, setQty] = useState(1);
  return (
    <motion.div 
      initial={{ opacity: 0, scale: 0.95 }} 
      animate={{ opacity: 1, scale: 1 }} 
      exit={{ opacity: 0, scale: 1.05 }}
      className="p-6 space-y-6"
    >
      <div className="relative aspect-square rounded-[2rem] overflow-hidden jelly-shadow border-4 border-white">
        <img src={candy.image} className="w-full h-full object-cover transform scale-110" alt={candy.name} />
        <div className="absolute bottom-4 right-4 sugar-glass px-4 py-2 rounded-full border border-white/40 flex items-center gap-2 shadow-lg">
          <Star className="text-yellow-400 fill-yellow-400" size={18} />
          <span className="font-black">{candy.rating}</span>
        </div>
      </div>

      <div className="space-y-4">
        <div className="flex justify-between items-start">
          <div>
            <h2 className="text-3xl font-extrabold text-primary tracking-tight">{candy.name}</h2>
            <p className="text-secondary font-black uppercase tracking-widest text-xs mt-1">{candy.subcategory}</p>
          </div>
          <div className="bg-primary-container/30 px-5 py-2 rounded-2xl">
            <span className="text-2xl font-black text-on-primary-container">${candy.price.toFixed(2)}</span>
          </div>
        </div>

        <p className="text-on-surface-variant leading-relaxed">
          {candy.description || "A premium confectionary treat crafted with the finest ingredients for a perfect sweet moment."}
        </p>

        <div className="flex items-center justify-between bg-surface-container-low p-4 rounded-3xl border border-primary/5">
          <span className="font-black text-primary">Select Quantity</span>
          <div className="flex items-center gap-6 bg-white rounded-full p-1 shadow-sm px-4">
            <button onClick={() => setQty(Math.max(1, qty - 1))} className="text-primary"><Minus size={20} /></button>
            <span className="text-xl font-black text-primary w-6 text-center">{qty}</span>
            <button onClick={() => setQty(qty + 1)} className="text-primary"><Plus size={20} /></button>
          </div>
        </div>

        <button 
          onClick={() => onAdd(qty)}
          className="w-full bg-primary text-white font-black text-xl py-5 rounded-full jelly-shadow active:scale-95 transition-all flex items-center justify-center gap-3 overflow-hidden"
        >
          <ShoppingBag size={24} />
          Add to Sweet Bag
        </button>
      </div>

      <div className="pt-6">
        <h3 className="text-xl font-extrabold mb-4">You might also like</h3>
        <div className="grid grid-cols-3 gap-4">
          {CANDIES.slice(0, 3).map(c => (
            <div key={c.id} className="aspect-square rounded-2xl overflow-hidden jelly-shadow border border-white">
              <img src={c.image} className="w-full h-full object-cover" alt={c.name} />
            </div>
          ))}
        </div>
      </div>
    </motion.div>
  );
}

function CandyCard({ candy, onClick }: { candy: Candy, onClick: () => void }) {
  return (
    <motion.div 
      whileHover={{ scale: 1.02 }}
      whileTap={{ scale: 0.98 }}
      onClick={onClick}
      className="bg-white rounded-[1.5rem] border border-primary/5 jelly-shadow overflow-hidden group cursor-pointer"
    >
      <div className="aspect-square relative overflow-hidden bg-pink-50">
        <img 
          src={candy.image} 
          className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" 
          alt={candy.name} 
        />
        <div className="absolute top-3 right-3 bg-white/80 sugar-glass rounded-full p-2 active:scale-90 transition-transform shadow-sm">
          <Heart size={16} className={candy.isPopular ? "fill-primary text-primary" : "text-primary/40"} />
        </div>
        {candy.isNew && (
           <div className="absolute top-3 left-3 bg-secondary-container text-on-secondary-container text-[8px] font-black uppercase px-2 py-0.5 rounded-full">
            NEW
          </div>
        )}
      </div>
      <div className="p-4">
        <h3 className="font-extrabold text-sm truncate">{candy.name}</h3>
        <p className="text-[10px] text-on-surface-variant font-medium">{candy.subcategory}</p>
        <div className="flex justify-between items-center mt-2">
          <span className="font-black text-primary">${candy.price.toFixed(2)}</span>
          <button 
            className="w-8 h-8 rounded-full bg-primary-container/40 text-primary flex items-center justify-center active:scale-90 transition-transform"
            onClick={(e) => { e.stopPropagation(); onClick(); }}
          >
            <ShoppingBag size={14} />
          </button>
        </div>
      </div>
    </motion.div>
  );
}
