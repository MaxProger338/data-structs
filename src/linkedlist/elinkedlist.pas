program ExtendedLinkedList;
uses LinkedList;

procedure LSTDeleteAt(var list: TList; index: listsize);
var
	pp: ^nodeptr;
	tmp: nodeptr;
	curPos: listsize;
begin
	pp := @list.first;
	curPos := 0;

	while pp^ <> nil do
	begin
		if curPos = index then 
		begin
			tmp := pp^;
			pp^ := pp^^.next;
			dispose(tmp);

			list.size := list.size - 1
		end
		else
			pp := @(pp^^.next);

		curPos := curPos + 1
	end
end;

var
	list: TList;
	i: integer;
begin
	LSTInit(list);
	LSTAddBack(list, 1);
	LSTAddBack(list, 2);
	LSTAddBack(list, 3);
	LSTAddBack(list, 4);
	LSTDeleteAt(list, 0);
	LSTDeleteAt(list, 0);
	LSTDeleteAt(list, 2);
	LSTDeleteAt(list, 3);
	
	for i := 0 to LSTGetSize(list) - 1 do
		writeln('[', i, '] - ', LSTGetAt(list, i));

	LSTDelete(list)
end.
