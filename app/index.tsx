import { useState } from 'react';
import { View, Text, FlatList, StyleSheet, TextInput, ScrollView, TouchableOpacity, useColorScheme } from 'react-native';
import { Stack, Link, useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '../constants/Colors';
import { PROPERTIES } from '../constants/MockData';
import PropertyCard from '../components/PropertyCard';
import { useAuth } from '../context/AuthContext';

const CATEGORIES = ['All', 'House', 'Apartment', 'Villa', 'Loft'];

export default function Home() {
    const colorScheme = useColorScheme();
    const router = useRouter();
    const theme = Colors[colorScheme ?? 'light'];
    const { user, signOut } = useAuth();

    const [activeCategory, setActiveCategory] = useState('All');
    const [searchQuery, setSearchQuery] = useState('');

    const filteredProperties = PROPERTIES.filter(prop => {
        const matchesSearch = prop.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
            prop.address.toLowerCase().includes(searchQuery.toLowerCase());
        const matchesCategory = activeCategory === 'All' || prop.title.toLowerCase().includes(activeCategory.toLowerCase());
        return matchesSearch && matchesCategory;
    });

    return (
        <View style={[styles.container, { backgroundColor: theme.background }]}>
            <Stack.Screen options={{
                headerRight: () => (
                    user ? (
                        <TouchableOpacity onPress={signOut}>
                            <Ionicons name="log-out-outline" size={24} color={theme.primary} />
                        </TouchableOpacity>
                    ) : (
                        <Link href="/auth/login" asChild>
                            <TouchableOpacity>
                                <Text style={{ color: theme.primary, fontWeight: 'bold' }}>Login</Text>
                            </TouchableOpacity>
                        </Link>
                    )
                ),
                headerSearchBarOptions: {
                    placeholder: "Search location, price...",
                    onChangeText: (event) => setSearchQuery(event.nativeEvent.text),
                    tintColor: theme.secondary,
                    textColor: theme.text,
                    hideWhenScrolling: false,
                }
            }} />

            <View style={styles.categoryContainer}>
                <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.categoryContent}>
                    {CATEGORIES.map((cat) => (
                        <TouchableOpacity
                            key={cat}
                            style={[
                                styles.categoryChip,
                                { backgroundColor: activeCategory === cat ? theme.primary : theme.card, borderColor: theme.border }
                            ]}
                            onPress={() => setActiveCategory(cat)}
                        >
                            <Text style={[
                                styles.categoryText,
                                { color: activeCategory === cat ? (colorScheme === 'dark' ? '#000' : '#fff') : theme.text }
                            ]}>
                                {cat}
                            </Text>
                        </TouchableOpacity>
                    ))}
                </ScrollView>
            </View>

            <FlatList
                data={filteredProperties}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => <PropertyCard property={item} />}
                contentContainerStyle={styles.listContent}
                showsVerticalScrollIndicator={false}
            />

            {user?.role === 'owner' && (
                <Link href="/owner/add-property" asChild>
                    <TouchableOpacity style={[styles.fab, { backgroundColor: theme.primary }]}>
                        <Ionicons name="add" size={32} color="white" />
                    </TouchableOpacity>
                </Link>
            )}
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    categoryContainer: {
        paddingVertical: 16,
    },
    categoryContent: {
        paddingHorizontal: 20,
        gap: 10,
    },
    categoryChip: {
        paddingHorizontal: 20,
        paddingVertical: 8,
        borderRadius: 20,
        borderWidth: 1,
        marginRight: 8,
    },
    categoryText: {
        fontWeight: '600',
    },
    listContent: {
        paddingBottom: 40,
    },
    fab: {
        position: 'absolute',
        bottom: 40,
        right: 20,
        width: 60,
        height: 60,
        borderRadius: 30,
        justifyContent: 'center',
        alignItems: 'center',
        padding: 0,
        elevation: 10,
        shadowColor: "#000",
        shadowOffset: { width: 0, height: 4 },
        shadowOpacity: 0.3,
        shadowRadius: 4.65,
    },
});
