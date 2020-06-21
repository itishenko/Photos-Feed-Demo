//
//  PhotosListViewModelTest.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

@testable import Demo
import XCTest
import SwiftyMocky

class PhotosListViewModelTest: BaseTestCase {
    
    func testConfigurationsWithEmptyList() throws {
        let mockOutput = PhotosListModuleOutputMock()
        let mockInteractor = PhotosListInteractorProtocolMock()
        let viewModel = PhotosListViewModel(
            output: mockOutput,
            interactor: mockInteractor
        )
        let observer = scheduler.createObserver([SectionConfiguration].self)
        viewModel.configurations.subscribe(observer).disposed(by: disposeBag)
        
        scheduler.start()
        
        Verify(mockOutput, .never, .openDetails(for: .any))
        
        XCTAssertEqual(observer.events.count, 1)
        
        let sections = try XCTUnwrap(observer.events.first?.value.element)
        XCTAssertEqual(sections.count, 0)
        
        XCTAssertEqual(viewModel.emptyListText, "There are no photos yet")
    }
    
    func testConfigurationsWithPhoto() throws {
        let mockOutput = PhotosListModuleOutputMock()
        let mockInteractor = PhotosListInteractorProtocolMock()
        let viewModel = PhotosListViewModel(
            output: mockOutput,
            interactor: mockInteractor
        )
        
        let photo = Photo(
            id: 1,
            albumId: 1,
            title: "1st photo",
            url: URL(string: "https://via.placeholder.com/600/61a61")!,
            thumbnailUrl: URL(string: "https://via.placeholder.com/150/61a61")!
        )
        
        mockOutput.matcher.register(Photo.self) { $0.id == $1.id }
        mockInteractor.given(.getPhotos(page: 0, limit: .value(PaginationState.Constants.pageSize), willReturn: scheduler.createColdSingle([photo])))
        
        let observer = scheduler.createObserver([SectionConfiguration].self)
        viewModel.configurations.subscribe(observer).disposed(by: disposeBag)
        viewModel.refresh()
        
        scheduler.start()
        
        XCTAssertEqual(observer.events.count, 2)
        
        let firstResult = try XCTUnwrap(observer.events.first?.value.element)
        XCTAssertEqual(firstResult.count, 0)
        
        let secondResult = try XCTUnwrap(observer.events.last?.value.element)
        XCTAssertEqual(secondResult.count, 1)
        
        let section = try XCTUnwrap(secondResult.first)
        XCTAssertEqual(section.rows.count, 1)
        
        let firstCell = try XCTUnwrap(section.rows.first as? PhotoCellConfiguration)
        XCTAssertEqual(firstCell.title, photo.title)
    }
    
    func testOpenDetailsWithTwoPhotos() throws {
        let mockOutput = PhotosListModuleOutputMock()
        let mockInteractor = PhotosListInteractorProtocolMock()
        
        let viewModel = PhotosListViewModel(
            output: mockOutput,
            interactor: mockInteractor
        )
        
        let photos = [
            Photo(
                id: 1,
                albumId: 1,
                title: "1st photo",
                url: URL(string: "https://via.placeholder.com/600/61a61")!,
                thumbnailUrl: URL(string: "https://via.placeholder.com/150/61a61")!
            ),
            Photo(
                id: 2,
                albumId: 1,
                title: "2nd photo",
                url: URL(string: "https://via.placeholder.com/600/61a62")!,
                thumbnailUrl: URL(string: "https://via.placeholder.com/150/61a62")!
            )
        ]
        
        mockOutput.matcher.register(Photo.self) { $0.id == $1.id }
        mockInteractor.given(.getPhotos(page: 0, limit: .value(PaginationState.Constants.pageSize), willReturn: scheduler.createColdSingle(photos)))
        
        let observer = scheduler.createObserver([SectionConfiguration].self)
        viewModel.configurations.subscribe(observer).disposed(by: disposeBag)
        viewModel.refresh()
        
        scheduler.start()
        
        XCTAssertEqual(observer.events.count, 2)
        let sections = try XCTUnwrap(observer.events.last?.value.element)
        XCTAssertEqual(sections.count, 1)
        let section = try XCTUnwrap(sections.first)
        XCTAssertEqual(section.rows.count, 2)
        
        section.clickRow(with: 0)
        
        Verify(mockOutput, 1, .openDetails(for: .value(photos.first!)))
    }
}
