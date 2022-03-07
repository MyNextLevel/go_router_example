import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'shared/data.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const String title = 'Nested Navigation';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
      );

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (_) => '/family/${Families.data[0].id}',
      ),
      GoRoute(
        path: '/family/:fid',
        builder: (BuildContext context, GoRouterState state) =>
            FamilyTabsScreen(
          key: state.pageKey,
          selectedFamily: Families.family(state.params['fid']!),
        ),
        routes: [
          GoRoute(
            path: 'person/:pid',
            builder: (BuildContext context, GoRouterState state) {
              final Family family = Families.family(state.params['fid']!);
              final Person person = family.person(state.params['pid']!);
              return PersonScreen(family: family, person: person);
            },
          ),
        ],
      ),
    ],
    navigatorBuilder: (
      BuildContext context,
      GoRouterState state,
      Widget child,
    ) =>
        Material(
      child: Column(
        children: [
          Expanded(child: child),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(state.location),
          ),
        ],
      ),
    ),
  );
}

class FamilyTabsScreen extends StatefulWidget {
  FamilyTabsScreen({required Family selectedFamily, Key? key})
      : index =
            Families.data.indexWhere((Family f) => f.id == selectedFamily.id),
        super(key: key) {
    assert(index != -1);
  }

  final int index;

  @override
  _FamilyTabsScreenState createState() => _FamilyTabsScreenState();
}

class _FamilyTabsScreenState extends State<FamilyTabsScreen>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: Families.data.length,
      vsync: this,
      initialIndex: widget.index,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FamilyTabsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.index = widget.index;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(App.title),
          bottom: TabBar(
            controller: _controller,
            tabs: <Tab>[
              for (final Family f in Families.data) Tab(text: f.name)
            ],
            onTap: (int index) => _tap(context, index),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            for (final Family f in Families.data) FamilyView(family: f)
          ],
        ),
      );

  void _tap(BuildContext context, int index) =>
      context.go('/family/${Families.data[index].id}');
}

class FamilyView extends StatefulWidget {
  const FamilyView({required this.family, Key? key}) : super(key: key);

  final Family family;

  @override
  State<FamilyView> createState() => _FamilyViewState();
}

class _FamilyViewState extends State<FamilyView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: <Widget>[
        for (final Person p in widget.family.people)
          ListTile(
            title: Text(p.name),
            onTap: () =>
                context.go('/family/${widget.family.id}/person/${p.id}'),
          ),
      ],
    );
  }
}

class PersonScreen extends StatelessWidget {
  const PersonScreen({required this.family, required this.person, Key? key})
      : super(key: key);

  final Family family;

  final Person person;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(person.name)),
        body: Text('${person.name} ${family.name} is ${person.age} years old'),
      );
}
