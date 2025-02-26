import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_proyecto_final/services/search_provider.dart';

class SearchWithAutocompleteInput<T extends Object> extends StatefulWidget {
  final Future<List<T>> Function(String) fetchFunction; // Función para buscar
  final String Function(T)
      displayStringForOption; // Para mostrar el objeto como String

  SearchWithAutocompleteInput(
      {Key? key,
      required this.fetchFunction,
      required this.displayStringForOption})
      : super(key: key);

  @override
  _SearchWithAutocompleteInputState<T> createState() =>
      _SearchWithAutocompleteInputState<T>();
}

class _SearchWithAutocompleteInputState<T extends Object>
    extends State<SearchWithAutocompleteInput<T>> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // Disparar búsqueda inicial con cadena vacía para obtener todos los resultados.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchProvider =
          Provider.of<SearchProvider<T>>(context, listen: false);
      searchProvider.onSearchChanged("", widget.fetchFunction);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider<T>>(context);
    return Autocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        // Actualiza las sugerencias en el provider
        print('textEditingValue.text');
        print(textEditingValue.text);
        searchProvider.onSearchChanged(
            textEditingValue.text, widget.fetchFunction);
        print('searchProvider.suggestions');
        print(searchProvider.suggestions);
        return searchProvider.suggestions;
      },
      displayStringForOption: widget.displayStringForOption,
      onSelected: (T selection) {
        // Aquí puedes definir qué sucede al seleccionar un objeto
        searchProvider.onSearchChanged(
            widget.displayStringForOption(selection), widget.fetchFunction);
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: "Buscar",
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: searchProvider.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
          ),
          onChanged: (query) {},
        );
      },
    );
  }
}
