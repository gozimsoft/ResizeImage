unit MainUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Layouts,
  FMX.ListBox;

type
  TFrmMain = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Layout2: TLayout;
    Label1: TLabel;
    Edit1: TEdit;
    Layout1: TLayout;
    Label2: TLabel;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      if Execute then
        Image1.Bitmap.LoadFromFile(FileName);
    finally
      Free;
    end;
end;

procedure TFrmMain.Button2Click(Sender: TObject);
var
  bmpB: TBitmap;
  src, trg: TRectF;
  i, _Width, _Height: Integer;
  tblw, tblh: array of Integer;
  _Ex: string;
var
  _path: string;
begin

  with Tsavedialog.Create(Self) do
    try
      FileName := 'image';
      Execute;
      _path := ExtractFilePath(FileName);
      if RadioButton1.IsChecked then
      begin
        tblw := tblw + [36] + [48] + [72] + [96] + [144] + [426] + [470] +
          [640] + [960];
        tblh := tblh + [36] + [48] + [72] + [96] + [144] + [320] + [320] +
          [480] + [720];
        for i := low(tblw) to High(tblw) do
        begin
          _Width := tblw[i];
          _Height := tblh[i];
          bmpB := TBitmap.Create;
          try
            bmpB.SetSize(_Width, _Height);
            src := RectF(0, 0, Image1.Bitmap.Width, Image1.Bitmap.Height);
            trg := RectF(0, 0, _Width, _Height);
            bmpB.Canvas.BeginScene;
            bmpB.Canvas.DrawBitmap(Image1.Bitmap, src, trg, 1);
            bmpB.Canvas.EndScene;
            bmpB.SaveToFile(_path + _Width.ToString + '_' + _Height.ToString
              + '.png');
          finally
            bmpB.Free;
          end;
        end;
      end
      else
      begin
        _Ex := '.' + ComboBox1.Items.Strings[ComboBox1.ItemIndex];
        _Width := StrToInt(Edit1.Text);
        _Height := StrToInt(Edit2.Text);
        bmpB := TBitmap.Create;
        try
          bmpB.SetSize(_Width, _Height);
          src := RectF(0, 0, Image1.Bitmap.Width, Image1.Bitmap.Height);
          trg := RectF(0, 0, _Width, _Height);
          bmpB.Canvas.BeginScene;
          bmpB.Canvas.DrawBitmap(Image1.Bitmap, src, trg, 1);
          bmpB.Canvas.EndScene;
          bmpB.SaveToFile(_path + _Width.ToString + '_' +
            _Height.ToString + _Ex);
        finally
          bmpB.Free;
        end;
      end;
      ShowMessage(' „ «·Õ›Ÿ');
    finally
      Free;
    end;
end;

procedure TFrmMain.RadioButton1Change(Sender: TObject);
begin
  ComboBox1.Visible := false;
  Layout2.Visible := false;
  Layout1.Visible := false;
end;

procedure TFrmMain.RadioButton2Change(Sender: TObject);
begin

  ComboBox1.Visible := True;
  Layout2.Visible := True;
  Layout1.Visible := True;

end;

end.
