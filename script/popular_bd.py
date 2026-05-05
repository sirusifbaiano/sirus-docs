import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'samu.settings')
django.setup()

from samu.tests.factories import UserFactory, User
from base.tests.factories import BaseFactory
from chamado.tests.factories import (
    ChamadoFactory, UnidadeChamadoFactory, 
    TramiteChamadoFactory, AtendimentoPessoaFactory,
    Chamado, UnidadeChamado, 
    TramiteChamado, AtendimentoPessoa
)
from colaborador.tests.factories import ColaboradorFactory, Colaborador
from fluxo.tests.factories import FluxoFactory, Fluxo
from setor.tests.factories import SetorFactory, Setor
from unidade.tests.factories import UnidadeFactory, Unidade
from notificacao.tests.factories import EventoFactory, PreferenciaDeNotificacaoFactory
from samu.utils import (
    CHAMADO_GRAVIDADE_CHOICES, 
    CHAMADO_OCORRENCIA_CHOICES, 
    STATUS_UNIDADE_CHOICES, 
    DESTINO_PACIENTE_CHOICES
)
import random
from datetime import datetime, timedelta
from django.utils import timezone
from django.db import transaction
from rest_framework.authtoken.models import Token
from django.contrib.auth.hashers import make_password

DESTINO_PACIENTE_CHOICES = [{"valor": valor} for valor, _ in DESTINO_PACIENTE_CHOICES[:-1]]

def gerar_data():
    MES_INICIAL = 1
    ANO_INICIAL = 2026

    MES_FINAL = 12
    ANO_FINAL = 2026
    
    # definir intervalo de datas
    data_inicial = datetime(ANO_INICIAL, MES_INICIAL, 1)
    data_final = datetime(ANO_FINAL, MES_FINAL, 31)

    # calcular intervalo em dias
    intervalo = data_final - data_inicial
    dias_totais = intervalo.days

    # gerar data aleatória
    quantidade_dias = random.randint(0, dias_totais)
    data_aleatoria = data_inicial + timedelta(days=quantidade_dias)

    # gerar hora, minuto e segundo aleatórios
    hora = random.randint(0, 23)
    minuto = random.randint(0, 59)
    segundo = random.randint(0, 59)

    data_aleatoria = data_aleatoria.replace(hour=hora, minute=minuto, second=segundo)
    data_aleatoria = timezone.make_aware(data_aleatoria)
    
    return data_aleatoria

def criar_superusuario():
    username = os.environ.get('DJANGO_SUPERUSER_USERNAME')
    email = os.environ.get('DJANGO_SUPERUSER_EMAIL')
    password = os.environ.get('DJANGO_SUPERUSER_PASSWORD')
    admin = UserFactory._meta.model.objects.create_superuser(username, email, password)
    Token.objects.create(user=admin)
    
    return admin

def criar_bases():
    print("Criandos bases...")
    dados_bases = (
        ('Base Caetité', 'Caetité'),
        ('Base Caculé', 'Caculé'),
        ('Base Botuporã', 'Botuporã'),
        ('Base Candiba', 'Candiba'),
        ('Base Carinhanha', 'Carinhanha'),
        ('Base Pindaí', 'Pindaí'),
    )
    central = BaseFactory(nome="Base Guanambi", cidade="Guanambi", central=None)
    bases = [BaseFactory(central=central, nome=n, cidade=c, uf='BA') for n, c in dados_bases]
    print(f"{len(bases)} bases criadas com sucesso.\n")
    
    return dados_bases, central, bases

def criar_unidades(admin, central, bases):
    print("Criando unidades...")
    STATUS_UNIDADE_CHOICES.pop(2)
    unidades = UnidadeFactory.create_batch(4, base=central, criado_por=admin, status=random.choice(STATUS_UNIDADE_CHOICES)[0])
    unidades += [UnidadeFactory.create_batch(2, base=base, criado_por=admin, tipo="USB", status=random.choice(STATUS_UNIDADE_CHOICES)[0]) for base in bases]
    print(f"{len(unidades)} unidades criadas com sucesso.\n")

def criar_setores(admin, central, bases):
    print("Criando setores...")
    dados_setores = [
        {
            "nome": "TARM", 
            "permissions": ['add_chamado']
        },
        {
            "nome": "Regulação", 
            "permissions": ['view_chamado', 'change_chamado']
        },
        {
            "nome": "Rádio", 
            "permissions": ['view_chamado']
        },
        {
            "nome": "Equipe de campo",
            "permissions": ['view_chamado', 'change_chamado']
        },
    ]
    setores = [
        SetorFactory(
            base=central, 
            name=setor["nome"], 
            criado_por=admin, 
            permissions=setor["permissions"],
            membro=[admin]
        ) 
        for setor in dados_setores
    ]
    setores += [SetorFactory(base=base) for base in bases] # setores das outras bases
    print(f"{len(setores)} setores criados com sucesso.\n")
    
    return setores

def criar_colaboradores(setores, admin):
    print("Criando colaboradores...")

    for setor in setores:
        colaboradores = ColaboradorFactory.create_batch(random.randint(1, 5), criado_por=admin, base_cadastro=setor.base)
        colaboradores_usuarios = [colaborador.usuario for colaborador in colaboradores ]
        setor.membro.set(colaboradores_usuarios)

    senha_padrao = os.environ.get('DEFAULT_COLABORADOR_PASSWORD', '123456')
    senha_padrao_hash = make_password(senha_padrao)
    User.objects.filter(is_superuser=False).update(password=senha_padrao_hash)

    print(f"{len(ColaboradorFactory._meta.model.objects.all())} colaboradores criados com sucesso.\n")

def criar_fluxos(central, setores):
    print("Criando fluxos...")
    fluxos = [FluxoFactory(central=central, setor=setor, ordem=i+1) for i, setor in enumerate(setores[:4])]
    print(f"{len(fluxos)} fluxos criados com sucesso.\n")

def criar_eventos():
    print("Criando eventos de notificação...")
    dados_eventos = [
        {
            "nome": 'chamado_encaminhado_para_etapa_2', 
            "descricao": 'Chamado encaminhado para o segundo setor do fluxo', 
            "titulo": 'Chamado encaminhado para $nome_setor',
            "mensagem": 'O chamado #$numero_chamado foi encaminhado para o setor $nome_setor',
            "permissions": ['view_chamado', 'change_chamado']
        },
        {
            "nome": 'chamado_encaminhado_para_etapa_3', 
            "descricao": 'Chamado encaminhado para o terceiro setor do fluxo', 
            "titulo": 'Chamado encaminhado para $nome_setor',
            "mensagem": 'O chamado #$numero_chamado foi encaminhado para o setor $nome_setor',
            "permissions": ['view_chamado']
        },
        {
            "nome": 'chamado_encaminhado_para_etapa_4', 
            "descricao": 'Chamado encaminhado para o último setor do fluxo', 
            "titulo": 'Chamado encaminhado para $nome_setor',
            "mensagem": 'O chamado #$numero_chamado foi encaminhado para o setor $nome_setor',
            "permissions": ['view_chamado', 'change_chamado']
        }
    ]
    eventos = [
        EventoFactory(nome=evento["nome"], descricao=evento["descricao"], titulo=evento["titulo"], mensagem=evento["mensagem"], permissions=evento["permissions"]) 
        for evento in dados_eventos
    ]
    print(f"{len(eventos)} eventos de notificação criados com sucesso.\n")

def criar_preferencias(setores):
    print("Criando preferências de notificação...")
    preferencias = []

    for setor in setores:
        permissions = setor.permissions.all().values_list("id", flat=True)
        permissions = list(permissions)
        eventos = EventoFactory._meta.model.objects.filter(permissions_hash__contained_by=permissions)
        membros = setor.membro.all()

        for membro in membros:
            for evento in eventos:
                preferencia = PreferenciaDeNotificacaoFactory(usuario=membro, evento=evento)
                preferencias.append(preferencia)
    
    print(f"{len(preferencias)} preferências de notificação criadas com sucesso.\n")

def criar_chamados(dados_bases, central, setores_fluxo):
    print("Criando chamados...")
    for _ in range(36):
        chamado = ChamadoFactory(
            base=central, 
            cidade=dados_bases[0][1], 
            gravidade=random.choice(CHAMADO_GRAVIDADE_CHOICES)[0], 
            tipo_ocorrencia=random.choice(CHAMADO_OCORRENCIA_CHOICES)[0],
            destino=random.choice(DESTINO_PACIENTE_CHOICES),
            status="EM_ANDAMENTO",
            criado_por=random.choice(setores_fluxo[0].membro.all())
        )
        chamado.criado_em = gerar_data()
        chamado.save()
    
    for _ in range(12):
        chamado = ChamadoFactory(
            base=central, 
            cidade=dados_bases[0][1], 
            gravidade=random.choice(CHAMADO_GRAVIDADE_CHOICES)[0], 
            tipo_ocorrencia=random.choice(CHAMADO_OCORRENCIA_CHOICES)[0],
            destino={'valor': 'OUTROS', 'complemento': random.choice(['Santa Casa', 'Posto de saúde', 'Hospital Carlos Chagas'])},
            status="EM_ANDAMENTO",
            criado_por=random.choice(setores_fluxo[0].membro.all())
        )
        chamado.criado_em = gerar_data()
        chamado.save()

    for _ in range(26):
        chamado = ChamadoFactory(
            base=central, 
            cidade=dados_bases[1][1], 
            gravidade=random.choice(CHAMADO_GRAVIDADE_CHOICES)[0], 
            tipo_ocorrencia=random.choice(CHAMADO_OCORRENCIA_CHOICES)[0],
            destino=random.choice(DESTINO_PACIENTE_CHOICES),
            status="EM_ANDAMENTO",
            criado_por=random.choice(setores_fluxo[0].membro.all())
        )
        chamado.criado_em = gerar_data()
        chamado.save()

    for _ in range(17):
        chamado = ChamadoFactory(
            base=central, 
            cidade=dados_bases[2][1], 
            gravidade=random.choice(CHAMADO_GRAVIDADE_CHOICES)[0], 
            tipo_ocorrencia=random.choice(CHAMADO_OCORRENCIA_CHOICES)[0],
            destino=random.choice(DESTINO_PACIENTE_CHOICES),
            status="EM_ANDAMENTO",
            criado_por=random.choice(setores_fluxo[0].membro.all())
        )
        chamado.criado_em = gerar_data()
        chamado.save()

    for _ in range(5):
        chamado = ChamadoFactory(
            base=central, 
            cidade=dados_bases[3][1], 
            gravidade=random.choice(CHAMADO_GRAVIDADE_CHOICES)[0], 
            tipo_ocorrencia=random.choice(CHAMADO_OCORRENCIA_CHOICES)[0],
            destino=random.choice(DESTINO_PACIENTE_CHOICES),
            status="ENCERRADO",
            criado_por=random.choice(setores_fluxo[0].membro.all())
        )
        chamado.criado_em = gerar_data()
        chamado.save()

    for _ in range(9):
        chamado = ChamadoFactory(
            base=central, 
            cidade=dados_bases[4][1], 
            gravidade=random.choice(CHAMADO_GRAVIDADE_CHOICES)[0], 
            tipo_ocorrencia=random.choice(CHAMADO_OCORRENCIA_CHOICES)[0],
            destino=random.choice(DESTINO_PACIENTE_CHOICES),
            status="PENDENTE",
            criado_por=random.choice(setores_fluxo[0].membro.all())
        )
        chamado.criado_em = gerar_data()
        chamado.save()

    for _ in range(7):
        chamado = ChamadoFactory(
            base=central, 
            cidade=dados_bases[5][1], 
            gravidade=random.choice(CHAMADO_GRAVIDADE_CHOICES)[0], 
            tipo_ocorrencia=random.choice(CHAMADO_OCORRENCIA_CHOICES)[0],
            destino=random.choice(DESTINO_PACIENTE_CHOICES),
            status="EM_ANDAMENTO",
            criado_por=random.choice(setores_fluxo[0].membro.all())
        )
        chamado.criado_em = gerar_data()
        chamado.save()

    print(f"{Chamado.objects.count()} chamados criados com sucesso.\n")

def criar_tramites_e_unidades_chamados(setores_fluxo):
    chamados = Chamado.objects.filter(status="EM_ANDAMENTO").select_related("base")

    print("Criando trâmites dos chamados e unidades_chamados...")
    for chamado in chamados:
        data_criacao = chamado.criado_em

        tramite_1_para_2_criador = random.choice(setores_fluxo[0].membro.all())
        tramite_1_para_2_recebedor = random.choice(setores_fluxo[1].membro.all())
        tramite_2_para_3_criador = tramite_1_para_2_recebedor
        tramite_2_para_3_recebedor = random.choice(setores_fluxo[2].membro.all())
        tramite_3_para_4_criador = tramite_2_para_3_recebedor
        tramite_3_para_4_recebedor = random.choice(setores_fluxo[3].membro.all())

        t = TramiteChamadoFactory(
            chamado=chamado, 
            setor_origem=setores_fluxo[0], 
            setor_destino=setores_fluxo[1], 
            criado_por=tramite_1_para_2_criador,
            aceito_por=tramite_1_para_2_recebedor,
        )
        t.criado_em = data_criacao + timedelta(minutes=2)
        t.aceito_em = data_criacao + timedelta(minutes=4)
        t.save()

        t = TramiteChamadoFactory(
            chamado=chamado, 
            setor_origem=setores_fluxo[1], 
            setor_destino=setores_fluxo[2], 
            criado_por=tramite_2_para_3_criador,
            aceito_por=tramite_2_para_3_recebedor,
        )
        t.criado_em = data_criacao + timedelta(minutes=5)
        t.aceito_em = data_criacao + timedelta(minutes=6)
        t.save()
        
        usuario_etapa_3 = random.choice(setores_fluxo[3].membro.all())
        t = TramiteChamadoFactory(
            chamado=chamado, 
            setor_origem=setores_fluxo[2], 
            setor_destino=setores_fluxo[3], 
            criado_por=tramite_3_para_4_criador,
            aceito_por=tramite_3_para_4_recebedor,
        )
        t.criado_em = data_criacao + timedelta(minutes=7)
        t.aceito_em = data_criacao + timedelta(minutes=8)
        t.save()

        uc = UnidadeChamadoFactory(
            chamado=chamado, 
            unidade=random.choice(chamado.base.unidades_operacionais.all()),
            alocado_por=usuario_etapa_3,
            status="FINALIZADO"
        )
        uc.alocado_em = data_criacao + timedelta(minutes=9)
        uc.save()

        chamado.status = "FINALIZADO"
        chamado.finalizado_em = data_criacao + timedelta(minutes=10)
        chamado.save()

    print(f"{TramiteChamado.objects.count()} trâmites criados com sucesso.\n")
    print(f"{UnidadeChamado.objects.count()} unidades_chamados criados com sucesso.\n")

def popular():
    with transaction.atomic():
        inicio = datetime.now()

        admin = criar_superusuario()
        dados_bases, central, bases = criar_bases()
        criar_unidades(admin, central, bases)
        setores = criar_setores(admin, central, bases)
        criar_fluxos(central, setores)
        criar_colaboradores(setores, admin)
        criar_eventos()
        criar_preferencias(setores[:4])

        # cria um colaborador para admin e configura suas preferências
        ColaboradorFactory(usuario=admin, email=admin.email, setores=setores[:4]) 
        eventos = EventoFactory._meta.model.objects.all()
        [PreferenciaDeNotificacaoFactory(usuario=admin, evento=eventos[1])]

        fluxos = Fluxo.objects.order_by("ordem").select_related("setor")
        setores_fluxo = [fluxo.setor for fluxo in fluxos]
        
        criar_chamados(dados_bases, central, setores_fluxo)
        criar_tramites_e_unidades_chamados(setores_fluxo)

        fim = datetime.now()
        duracao = fim - inicio
        print(f"Registros criados em {duracao.total_seconds():.2f} segundos.")

if __name__ == '__main__':
    popular()