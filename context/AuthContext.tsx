import React, { createContext, useContext, useState, ReactNode } from 'react';
import { useRouter, useSegments } from 'expo-router';

type UserRole = 'owner' | 'tenant';

interface User {
    id: string;
    email: string;
    name: string;
    role: UserRole;
}

interface AuthContextType {
    user: User | null;
    signIn: (email: string, role: UserRole) => void;
    signOut: () => void;
    isAuthenticated: boolean;
}

const AuthContext = createContext<AuthContextType | null>(null);

export function useAuth() {
    const context = useContext(AuthContext);
    if (!context) {
        throw new Error('useAuth must be used within an AuthProvider');
    }
    return context;
}

export function AuthProvider({ children }: { children: ReactNode }) {
    const [user, setUser] = useState<User | null>(null);
    const router = useRouter();

    const signIn = (email: string, role: UserRole) => {
        // Simulate auth
        setUser({
            id: '123',
            email,
            name: email.split('@')[0],
            role,
        });

        // Navigation logic will be handled by the protected layout or component
        if (role === 'owner') {
            router.replace('/'); // Or owner dashboard
        } else {
            router.replace('/');
        }
    };

    const signOut = () => {
        setUser(null);
        router.replace('/auth/login');
    };

    return (
        <AuthContext.Provider
            value={{
                user,
                signIn,
                signOut,
                isAuthenticated: !!user,
            }}
        >
            {children}
        </AuthContext.Provider>
    );
}
