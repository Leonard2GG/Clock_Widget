import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HomeWidget initialization (optional for this app)
  runApp(const ClockApp());
}

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic;
          darkColorScheme = darkDynamic;
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: 'Clock Widget',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            fontFamily: 'sans-serif-medium',
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            fontFamily: 'sans-serif-medium',
          ),
          themeMode: ThemeMode.system,
          home: const ClockHome(),
        );
      },
    );
  }
}

class ClockHome extends StatefulWidget {
  const ClockHome({super.key});

  @override
  State<ClockHome> createState() => _ClockHomeState();
}

class _ClockHomeState extends State<ClockHome> {
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeStream = Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Expandable SliverAppBar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Clock',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.1),
                      colorScheme.secondary.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Content
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Main Clock Widget Card
                _buildClockCard(context, colorScheme, isDark),
                const SizedBox(height: 24),
                // Features Section
                Text(
                  'Features',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(context, colorScheme, isDark),
                const SizedBox(height: 24),
                // Clock Format Section
                Text(
                  'Widget Settings',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                _buildSettingsCard(context, colorScheme, isDark),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClockCard(
      BuildContext context, ColorScheme colorScheme, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade900.withValues(alpha: 0.5)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          children: [
            StreamBuilder<DateTime>(
              stream: _timeStream,
              builder: (context, snapshot) {
                final now = snapshot.data ?? DateTime.now();
                final hour = now.hour.toString().padLeft(2, '0');
                final minute = now.minute.toString().padLeft(2, '0');
                final second = now.second.toString().padLeft(2, '0');

                return Column(
                  children: [
                    Text(
                      '$hour:$minute',
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      second,
                      style: TextStyle(
                        fontSize: 20,
                        color: colorScheme.primary.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _formatDate(now),
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark
                            ? Colors.grey.shade300
                            : Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, ColorScheme colorScheme, bool isDark) {
    final features = [
      ('🔄', 'Auto Update', 'TextClock updates without battery drain'),
      ('🎨', 'Dynamic Color', 'Material You color integration'),
      ('🌓', 'Dark Mode', 'Glassmorphism support'),
    ];

    return Column(
      children: features
          .map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.grey.shade800.withValues(alpha: 0.3)
                        : Colors.grey.shade100.withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.black.withValues(alpha: 0.03),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        feature.$1,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feature.$2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              feature.$3,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildSettingsCard(
      BuildContext context, ColorScheme colorScheme, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade900.withValues(alpha: 0.5)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _settingsTile(
            context,
            'Widget Size',
            'Add to home screen (4x3 cells)',
            Icons.dashboard_customize,
            colorScheme,
            isDark,
          ),
          const Divider(height: 24),
          _settingsTile(
            context,
            'Update Frequency',
            'Updates every 60 seconds',
            Icons.schedule,
            colorScheme,
            isDark,
          ),
          const Divider(height: 24),
          _settingsTile(
            context,
            'Material You',
            'Follows system colors',
            Icons.palette,
            colorScheme,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _settingsTile(BuildContext context, String title, String subtitle,
      IconData icon, ColorScheme colorScheme, bool isDark) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dateTime) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    
    return '${days[dateTime.weekday - 1]}, ${months[dateTime.month - 1]} ${dateTime.day}';
  }
}

